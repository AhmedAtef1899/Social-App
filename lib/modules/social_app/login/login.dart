import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/social_layout.dart';
import 'package:login/modules/social_app/login/cubit/cubit.dart';
import 'package:login/modules/social_app/login/cubit/state.dart';
import 'package:login/modules/social_app/register/Register.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children:  [
                          const Text(
                            'Sign In',style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultForm(
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                              type: TextInputType.emailAddress,
                              controller: emailController,
                              validate: (value)
                              {
                                if (value.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultForm(
                              label: 'Password',
                              prefix: Icons.lock_outline,
                              type: TextInputType.visiblePassword,
                              controller: passController,
                              suffix: SocialLoginCubit.get(context).suffix,
                              suffixPressed: (){
                                SocialLoginCubit.get(context).changePass();
                              },
                              isPassword: SocialLoginCubit.get(context).isPassword,
                              validate: (value)
                              {
                                if (value.isEmpty)
                                {
                                  return 'Empty';
                                }
                                return null;
                              }
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultButton(
                              text: 'Log In',
                              function: (){
                                if(formKey.currentState!.validate())
                                  {
                                    SocialLoginCubit.get(context).getLogin(
                                        email: emailController.text,
                                        password: passController.text
                                    );
                                  }
                              }
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'No Account?',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                              TextButton(onPressed: (){
                                navigateTo(context,
                                  SocialRegisterScreen()
                                );
                              }, child:
                                  const Text(
                                    'Create One',
                                    style: TextStyle(
                                        fontSize: 16
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context,state){
            if(state is SocialLoginSuccessState)
              {
                CacheHelper.saveData(key: 'uId',
                    value: state.uId
                ).then((value) {
                  navigateAndFinish(context,  SocialLayout());
                });
              }
          }
      )
    );
  }
}
