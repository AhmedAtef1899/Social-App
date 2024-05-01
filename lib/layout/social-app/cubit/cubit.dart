import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/chat_model.dart';
import 'package:login/models/social_app/comment_model.dart';
import 'package:login/models/social_app/post_model.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/chats/chats.dart';
import 'package:login/modules/social_app/feeds/feeds.dart';
import 'package:login/modules/social_app/post/post_screen.dart';
import 'package:login/modules/social_app/setting/setting.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:login/modules/social_app/users/users.dart';
import 'package:path/path.dart';

class SocialLayoutCubit extends Cubit<SocialLayoutStates>
{
  SocialLayoutCubit() : super(SocialLayoutInitialState());

  static SocialLayoutCubit get(context) => BlocProvider.of(context);

  SocialUserModel? socialUserModel;

   File? image;
  void pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
      image = File(pickedFile.path);

      emit(SocialPickedSuccessImageState());
    }
    else
      {
        emit(SocialPickedErrorImageState());
      }
  }

  Future<void> uploadImageToStorage({
    required String name,
    required String bio,
    required String phone,
}) async {
    debugPrint("File is : $image}");
    debugPrint("Base Name fro File is : ${basename(image!.path)}");
    Reference imageRef = FirebaseStorage.instance.ref(basename(image!.path));
    await imageRef.putFile(image!);
    await imageRef.getDownloadURL().then((value)
    {
      print(value);
      updateData(
          name: name,
          bio: bio,
          phone: phone,
        imageUser: value
      );
      emit(SocialLayoutUploadSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLayoutUploadErrorState());
    });
  }

  File? postImage;

  void pickPostImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
       postImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    }
    else
    {
      emit(SocialPickedPostImageErrorState());
    }
  }

  Future<void> createPost({
    required String text,
    required String date,
}) async
  {
    emit(SocialLayoutCreatePostLoadingState());
    Reference imageRef = FirebaseStorage.instance.ref(basename(postImage!.path));
    await imageRef.putFile(postImage!);
    await imageRef.getDownloadURL().then((value)
    {
      print(value);
      createPostData(
        text: text,
        date: date,
        postImage: value
      );
      emit(SocialLayoutCreatePostSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLayoutCreatePostErrorState());
    });
  }


  SocialPostModel? socialPostModel;

  void createPostData({
    required String text,
    required String date,
    String? postImage
  }){
    emit(SocialLayoutCreatePostLoadingState());
    socialPostModel = SocialPostModel(
      name: socialUserModel?.name,
      image: socialUserModel?.image,
      uId: socialUserModel?.uId,
      text: text,
      postImage: postImage ?? '',
      date: date,
    );
    FirebaseFirestore.instance.collection('posts')
        .add(socialPostModel!.toMap())
        .then((value)
    {
      emit(SocialCreateDatePostSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialCreateDatePostErrorState());
    });
  }

  List<SocialPostModel> posts = [];
  List<String> postsId = [];
  List<String> commentsId = [];
  List<int> likes = [];
  List<int> commentId =[];

  void getPost()
  {
    emit(SocialLayoutGetPostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .listen((value)
    {
      for (var element in value.docs)
      {
        element.reference.collection('likes')
        .get()
        .then((value) {
          likes.add(value.docs.length);
          commentId.add(value.docs.length);
          postsId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
        }).catchError((onError){

        });

      }
      emit(SocialLayoutGetPostSuccessState());
    });
  }

 List<SocialCommentModel> comments = [];

  SocialCommentModel? socialCommentModel;
  void fetchCommentsForPost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((querySnapshot) {
          comments=[];
      for (var doc in querySnapshot.docs) {
        commentsId.add(doc.id);
        print(doc.id);
        comments.add(SocialCommentModel.fromJson(doc.data()));
      }
      emit(SocialLayoutCommentsLoadedState(comments.toString()));
    });
  }
  void commentOnPost(String postId, String commentText) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'comment': commentText,
      'commenterId': socialUserModel?.uId,
      'timestamp': DateTime.now().toIso8601String(),
    }).then((value)
    {
      print(postId);
      fetchCommentsForPost(postId);
      emit(SocialLayoutCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialLayoutCommentPostErrorState());
    });
  }

  bool colorIcon = false;
  IconData iconData = Icons.favorite;

  void changeColor()
  {
    colorIcon = !colorIcon;
    emit(SocialLayoutColorLikeState());
  }

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel?.uId)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // User already liked the post
        emit(SocialLayoutLikePostErrorState()); // Optionally emit an error state or handle it differently
      } else {
        // User hasn't liked the post yet, add their like
        FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .collection('likes')
            .doc(socialUserModel?.uId)
            .set({'like': true})
            .then((value) {
          emit(SocialLayoutLikePostSuccessState());
        }).catchError((onError) {
          print(onError.toString());
          emit(SocialLayoutLikePostErrorState());
        });
      }
    });
  }


  void updateData({
    required String name,
    required String bio,
    required String phone,
    String? imageUser,
}){
    socialUserModel = SocialUserModel(
      name: name,
      bio: bio,
      image: imageUser ?? socialUserModel?.image,
      email: socialUserModel?.email,
      password: socialUserModel?.password,
      phone: phone,
      uId: socialUserModel?.uId,
    );
    FirebaseFirestore.instance.collection('users')
        .doc(socialUserModel!.uId)
        .update(socialUserModel!.toMap())
        .then((value)
    {
      getUser();
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLayoutUpdateErrorState());
    });
  }

  void getUser()
  {
    User? user = FirebaseAuth.instance.currentUser;
    emit(SocialLayoutGetLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc('SalD9U8sR4cRU3b2uLM8f5LjY2g2')
        .get()
        .then((value)
    {
      print(value.data());
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialLayoutGetSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLayoutGetErrorState());
    });
  }

  List<SocialUserModel> users=[];

  void getUsers()
  {
    emit(SocialLayoutGetAllUsersLoadingState());
    if (users.isEmpty) {
        FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != socialUserModel?.uId ) {
            users.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(SocialLayoutGetAllUsersSuccessState());
      }).catchError((onError) {
        emit(SocialLayoutGetAllUsersErrorState());
      });
    }
  }

  SocialChatModel? chatModel;
  void sendMassage({
  required String? dateTime,
    required String? text,
    required String? receiverId,
    String? image,
})
 async {
    emit(SocialSendMessageImageLoadingState());
    SocialChatModel chatModel = SocialChatModel(
      dateTime: dateTime,
      receiverId: receiverId,
      senderId: socialUserModel?.uId,
      text: text,
      image: image ?? ''
    );
    FirebaseFirestore.instance.collection('users')
    .doc(socialUserModel?.uId)
    .collection('chat')
    .doc(receiverId)
    .collection('messages')
    .add(chatModel.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError){
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance.collection('users')
        .doc(receiverId)
        .collection('chat')
        .doc(socialUserModel?.uId)
        .collection('messages')
        .add(chatModel.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError){
      emit(SocialSendMessageErrorState());
    });
    Reference imageRef = FirebaseStorage.instance.ref(basename(messageImage!.path));
    await imageRef.putFile(messageImage!);
    await imageRef.getDownloadURL().then((value)
    {
      print(value);
      sendMassage(
        text: text,
        receiverId:  receiverId,
        image: value,
        dateTime: dateTime,
      );
      emit(SocialSendMessageSuccessState());
    }).catchError((onError){
      print(onError.toString());
      emit(SocialSendMessageErrorState());
    });
  }


  List<SocialChatModel> messages = [];


  void getMessages({required String receiverId})
  {
    FirebaseFirestore.instance.collection('users')
        .doc(socialUserModel?.uId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          for (var element in event.docs) {
            messages.add(SocialChatModel.fromJson(element.data()));
          }
          emit(SocialGetMessageSuccessState());
    });
  }

  File? messageImage;

  void removeImage()
  {
    messageImage = null;
    emit(SocialRemoveImageState());
  }

  void removeImagePost()
  {
    postImage = null;
    emit(SocialRemoveImageState());
  }

  void pickImageToChat() async
  {
    final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null)
      {
        messageImage = File(pickedFile.path);
        emit(SocialPickedMessageImageSuccessState());
      }
      else
      {
        emit(SocialPickedMessageImageErrorState());
      }
  }



  int currentIndex = 0;

  List<Widget> screens=
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  List<String> titles =[
    'Home',
    'Chats',
    'Add Post',
    'Users',
    'Setting',
  ];

  List<BottomNavigationBarItem> barItem =
  [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'HOME'
    ),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.chat_bubble_2), label: 'CHATS'
    ),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.add_circled,), label: 'New'
    ),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.location_solid), label: 'USERS'
    ),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'SETTINGS'
    ),

  ];
  void changeNav(int index)
  {
    if (index == 1 || index == 3)
      {
        getUsers();
      }
    if(index == 2)
      {
        emit(SocialAddPostState());
      }
    else
    {
      currentIndex = index;
      emit(SocialChangeBottomNav());
    }
  }


}