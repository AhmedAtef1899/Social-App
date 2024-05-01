abstract class SocialLoginStates{}

class SocialInitialState extends SocialLoginStates{}

class SocialChangeVisible extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSuccessState extends SocialLoginStates{
  final String?  uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates{}