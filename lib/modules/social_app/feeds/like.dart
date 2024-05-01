import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/social_user_model.dart';

class LikeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(builder: (context,state) => Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.separated(itemBuilder: (context,index) => likePost(context,SocialLayoutCubit.get(context).socialUserModel!),
                  separatorBuilder: (context,index)=>const SizedBox(height: 15,),
                  itemCount: SocialLayoutCubit.get(context).likes.length
              ),
            )
          ],
        ),
      ),
    ),
      listener: (context,state){},
    );
  }
}

Widget likePost(context,SocialUserModel userModel) => Row(
  children: [
    CircleAvatar(
      radius: 45,
      backgroundImage: NetworkImage('${userModel.image}'),
    ),
    const SizedBox(
      width: 15,
    ),
    Text(
        '${userModel.name}',
        style: Theme.of(context).textTheme.titleLarge
    ),
    const SizedBox(
      height: 7,
    ),
  ],
);