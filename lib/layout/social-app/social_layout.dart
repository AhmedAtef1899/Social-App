import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/modules/social_app/post/post_screen.dart';
import 'package:login/shared/components/components.dart';


class SocialLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      builder: (context,state) => Scaffold(
        appBar: AppBar(
          title: Text(
              SocialLayoutCubit.get(context).titles[SocialLayoutCubit.get(context).currentIndex]
          ),
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(
              Icons.search
            )),
            IconButton(onPressed: (){}, icon: const Icon(
              Icons.notifications_none
            ))
          ],
        ),
        body:SocialLayoutCubit.get(context).screens[SocialLayoutCubit.get(context).currentIndex],
        bottomNavigationBar: BottomNavigationBar(

          items: SocialLayoutCubit.get(context).barItem,
          elevation: 5,
          currentIndex: SocialLayoutCubit.get(context).currentIndex,
          onTap: (index){
            SocialLayoutCubit.get(context).changeNav(index);
          },
        ),
        ) ,
      listener: (context,state){
        if(state is SocialAddPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
    );
  }
}
// if (SocialLayoutCubit.get(context).socialUserModel != null)
// if(FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// color: Colors.amber.withOpacity(0.4),
// height: 70,
// child: Padding(
// padding: const EdgeInsets.all(20),
// child: Row(
// children: [
// const Icon(
// Icons.info_outlined
// ),
// const SizedBox(
// width:5,
// ),
// const Text("Please Verify Email",style: TextStyle(
// color: Colors.black,
// fontSize: 15
// ),
// ),
// const SizedBox(
// width: 60,
// ),
// defaultButton(
// width: 100,
// text: 'Verify'
// , function: (){
// FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value){
// print('done');
// }).catchError((error){
// print(error.toString());
// });
// }
// )
// ],
// ),
// ),
// )