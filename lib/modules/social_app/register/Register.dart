import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/social_layout.dart';
import 'package:login/modules/social_app/register/cubit/cubit.dart';
import 'package:login/modules/social_app/register/cubit/state.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/network/local/cache_helper.dart';

class SocialRegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('REGISTER'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultForm(
                      label: 'Name',
                      prefix: Icons.man,
                      type: TextInputType.text,
                      controller: nameController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                      label: 'Email',
                      prefix: Icons.email,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                      label: 'Phone',
                      prefix: Icons.phone_android,
                      type: TextInputType.text,
                      controller: phoneController,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultForm(
                      label: 'Password',
                      prefix: Icons.lock,
                      type: TextInputType.visiblePassword,
                      controller: passController,
                      isPassword: SocialRegisterCubit.get(context).isPassword,
                      suffix: SocialRegisterCubit.get(context).suffix,
                      suffixPressed: (){
                        SocialRegisterCubit.get(context).changePass();
                      },
                      validate: (value) {
                        if (value.isEmpty)
                        {
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            color: Colors.black,
                            spreadRadius: 0.0,
                            blurRadius: 2,
                            offset: Offset(3, 0),
                          ),
                          BoxShadow(
                            blurStyle: BlurStyle.outer,
                            color: Colors.black,
                            spreadRadius: 0.0,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).getRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text,
                                  password: passController.text
                              );
                            }
                        },
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'REGISTER',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              width: 100,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        listener: (context, state) {
          if (state is SocialRegisterCreationSuccessState)
          {
            navigateAndFinish(context,  SocialLayout());
          }
        },
      ),
    );
  }
}
