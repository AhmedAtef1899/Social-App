
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/social_app/login/cubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialInitialState());
  static SocialLoginCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;

  IconData suffix = CupertinoIcons.eye;
  void changePass()
  {
    isPassword = !isPassword;
    if(isPassword == true)
    {
      suffix = CupertinoIcons.eye;
    }
    else
    {
      suffix = CupertinoIcons.eye_slash;
    }
    emit(SocialChangeVisible());
  }

  void getLogin({
  required String email,
    required String password,
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
    ).then((value) {
      print(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((onError){
      print(onError.toString());
      emit(SocialLoginErrorState());
    });
  }


}