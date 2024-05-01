import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/chats/chat_details.dart';
import 'package:login/shared/components/components.dart';

class UserScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        builder: (context,state) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context,index) => allUsers(context,SocialLayoutCubit.get(context).users[index]),
            separatorBuilder: (context,index)=>line(),
            itemCount: SocialLayoutCubit.get(context).users.length
        ),
        listener: (context,state){}
    );
  }
}

Widget allUsers(context,SocialUserModel userModel) =>  InkWell(
  onTap: (){
  },
  child:  Padding(
    padding: const EdgeInsets.all(15.0),
    child: Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage('${userModel.image}'),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          'Name: ${userModel.name}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Phone: ${userModel.phone}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          'Email: ${userModel.email}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    ),
  ),
);
