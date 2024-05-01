

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/layout/social-app/social_layout.dart';
import 'package:login/modules/social_app/login/login.dart';
import 'package:login/native_code.dart';
import 'package:login/shared/bloc_observ.dart';
import 'package:login/shared/network/local/cache_helper.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/styles/themes.dart';
import 'shared/components/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  dioHelper.init();
  await CacheHelper.init();
  bool iconMode = CacheHelper.getData(key: 'iconMode') ?? false;
  // token = CacheHelper.getData(key: 'token') ?? '';
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  // });
  uId = CacheHelper.getData(key: 'uId') ?? '';
  Widget widget;
  if(uId != null)
    {
       widget =  SocialLayout();
    }
  else
    {
      widget = LoginScreen();
    }

      runApp( MyApp(
    startWidget:widget,
    iconMode:iconMode,
  ));
}
class MyApp extends StatelessWidget
{
  final bool iconMode;
  final Widget startWidget;
  const MyApp({Key? key, required this.iconMode, required this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialLayoutCubit()..getUser()..getPost(),
        ),
      ],
        child: BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
            builder: (context,state) => MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: themeLight,
              darkTheme: themeDark,
              themeMode: ThemeMode.light,
              home: LoginScreen(),
            ),
            listener: (context,state) {}
        ),
    );
  }
}


// create: (BuildContext context) => newsCubit()..getBusiness()..changeMode(
// fromShared: iconMode
// ),

