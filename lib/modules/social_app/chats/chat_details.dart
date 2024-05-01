import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/chat_model.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/chats/image_chat.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/styles/color.dart';

class ChatDetailsScreen extends StatelessWidget {
  GlobalKey messageImageKey = GlobalKey();
  SocialUserModel? userModel;
  var formKey = GlobalKey<ScaffoldState>();
  var messageController = TextEditingController();
  ChatDetailsScreen({Key? key,
     this.userModel
}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SocialLayoutCubit.get(context).getMessages(receiverId: userModel!.uId!);
    return Builder(
      builder: (BuildContext context){
        return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
            builder: (context,state)=>Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage('${userModel?.image}'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        '${userModel?.name}'
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                   if (state is SocialSendMessageImageLoadingState)
                      const LinearProgressIndicator(),
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                          itemBuilder: (context,index)
                          {
                            var message = SocialLayoutCubit.get(context).messages[index];
                            if(SocialLayoutCubit.get(context).socialUserModel?.uId == message.senderId) {
                              return myMessages(SocialLayoutCubit.get(context).messages[index],context);
                            }
                            return myFriendMessages(SocialLayoutCubit.get(context).messages[index],context);
                          },
                          separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                          itemCount: SocialLayoutCubit.get(context).messages.length
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (SocialLayoutCubit.get(context).messageImage != null)
                      Card(
                        key: messageImageKey,
                        elevation: 10,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.all(8),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image(
                              image: FileImage(SocialLayoutCubit.get(context).messageImage!),
                              height: 250,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            IconButton(onPressed: (){
                              SocialLayoutCubit.get(context).removeImage();
                            }, icon: const Icon(
                              Icons.close
                            ))
                          ],
                        ),
                      ),

                    const SizedBox(
                      height: 20,
                      ),
                    Form(
                      key: formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.deepPurpleAccent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              child: IconButton(onPressed:(){
                                SocialLayoutCubit.get(context).pickImageToChat();
                              }, icon: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              )),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic
                                ),
                                decoration: const InputDecoration(
                                  hintText: 'Send massage',
                                  border: InputBorder.none,
                                ),
                                controller: messageController,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: IconButton(onPressed: (){
                                DateTime now = DateTime.now();
                                SocialLayoutCubit.get(context).sendMassage(
                                  dateTime: now.toString(),
                                    text: messageController.text,
                                    receiverId: userModel!.uId!,
                                );
                                messageController.text = '';
                                SocialLayoutCubit.get(context).removeImage();
                              }, icon: const Icon(
                                  Icons.send_outlined,
                                color: Colors.white,
                              )),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            listener: (context,state){}
        );
      },
    );
  }
}

Widget myMessages(SocialChatModel chatModel,context) =>   Align(
  alignment: Alignment.centerRight ,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      if (chatModel.text != '' )
        Container(
          padding: const EdgeInsets.all(10),
          decoration:  BoxDecoration(
              color: Colors.green[600],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10) ,
                  topRight:Radius.circular(10) ,
                  bottomLeft: Radius.circular(10)
              )
          ),
          child: Text(
              '${chatModel.text}',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              fontStyle: FontStyle.italic
            ),
          ),
        ),
      if (chatModel.image != '' )
        GestureDetector(
          onLongPress: (){

          },
          child: Container(
            height: 300,
            width: 300,
            decoration:  BoxDecoration(
              border: const BorderDirectional(top: BorderSide(
                style: BorderStyle.solid,
              ),
                start: BorderSide(
                  style: BorderStyle.solid,
                ),
                end: BorderSide(
                  style: BorderStyle.solid,
                ),
                bottom: BorderSide(
                  style: BorderStyle.solid,width: 10
                ),
              ),
              borderRadius: BorderRadius.circular(7),
              image:  DecorationImage(
                  image: NetworkImage('${chatModel.image}'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
    ],
  ),
);

Widget myFriendMessages(SocialChatModel chatModel,context)=>Align(
  alignment: Alignment.centerLeft,
  child: Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10) ,
            topRight:Radius.circular(10) ,
            bottomRight: Radius.circular(10)
        )
    ),
    child:  Column(
      children: [
        Text(
            '${chatModel.text}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontStyle: FontStyle.italic
          ),
        ),
        if (chatModel.image != '' )
          Container(
            height: 150,
            width: 150,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image:  DecorationImage(
                  image: NetworkImage('${chatModel.image}'),
                  fit: BoxFit.cover),
            ),
          ),
      ],
    ),
  ),
);
