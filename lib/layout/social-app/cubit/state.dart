import 'dart:io';

abstract class SocialLayoutStates{}

class SocialLayoutInitialState extends SocialLayoutStates{}

class SocialLayoutGetLoadingState extends SocialLayoutStates{}

class SocialLayoutGetSuccessState extends SocialLayoutStates{}

class SocialLayoutGetErrorState extends SocialLayoutStates{}

class SocialChangeBottomNav extends SocialLayoutStates{}

class SocialAddPostState extends SocialLayoutStates{}

class SocialPickedSuccessImageState extends SocialLayoutStates {}

class SocialPickedErrorImageState extends SocialLayoutStates {}

class SocialLayoutUploadSuccessState extends SocialLayoutStates{}

class SocialLayoutUploadErrorState extends SocialLayoutStates{}

class SocialLayoutUpdateErrorState extends SocialLayoutStates{}


// create post

class SocialLayoutCreatePostSuccessState extends SocialLayoutStates{}

class SocialLayoutCreatePostErrorState extends SocialLayoutStates{}

class SocialLayoutCreatePostLoadingState extends SocialLayoutStates{}

class SocialPickedPostImageSuccessState extends SocialLayoutStates{}

class SocialPickedPostImageErrorState extends SocialLayoutStates{}

class SocialCreateDatePostErrorState extends SocialLayoutStates{}

class SocialCreateDatePostSuccessState extends SocialLayoutStates{}

class SocialLayoutGetPostLoadingState extends SocialLayoutStates{}

class SocialLayoutGetPostSuccessState extends SocialLayoutStates{}

class SocialLayoutGetPostErrorState extends SocialLayoutStates{}

class SocialLayoutLikePostSuccessState extends SocialLayoutStates{}

class SocialLayoutLikePostErrorState extends SocialLayoutStates{}

class SocialLayoutCommentPostSuccessState extends SocialLayoutStates{}

class SocialLayoutColorLikeState extends SocialLayoutStates{}

class SocialLayoutCommentPostErrorState extends SocialLayoutStates{}

class SocialLayoutGetAllUsersLoadingState extends SocialLayoutStates{}

class SocialLayoutGetAllUsersSuccessState extends SocialLayoutStates{}

class SocialLayoutGetAllUsersErrorState extends SocialLayoutStates{}

class SocialSendMessageSuccessState extends SocialLayoutStates{}

class SocialSendMessageErrorState extends SocialLayoutStates{}

class SocialGetMessageSuccessState extends SocialLayoutStates{}

class SocialGetMessageErrorState extends SocialLayoutStates{}

class SocialPickedMessageImageSuccessState extends SocialLayoutStates{}

class SocialPickedMessageImageErrorState extends SocialLayoutStates{}

class SocialSendMessageImageSuccessState extends SocialLayoutStates{}

class SocialSendMessageImageErrorState extends SocialLayoutStates{}

class SocialSendMessageImageLoadingState extends SocialLayoutStates{}

class SocialRemoveImageState extends SocialLayoutStates{}

class SocialGetCommentSuccessState extends SocialLayoutStates{}

class SocialGetCommentErrorState extends SocialLayoutStates{}


class SocialLayoutCommentsLoadedState extends SocialLayoutStates{

  final String comment;

  SocialLayoutCommentsLoadedState(this.comment);
}



