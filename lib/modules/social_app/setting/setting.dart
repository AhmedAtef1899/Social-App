import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/edit_profile/edit_screen.dart';
import 'package:login/modules/social_app/login/login.dart';
import 'package:login/shared/components/components.dart';
import 'package:login/shared/network/local/cache_helper.dart';

import '../../../models/social_app/post_model.dart';
import '../feeds/comment_screen.dart';


class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = SocialLayoutCubit.get(context).socialUserModel;
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
      builder: (context,state) =>Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                 Expanded(
                   child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      NetworkImage(
                          cubit?.image ?? ''
                      )
                                   ),
                 ),
                 Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${SocialLayoutCubit.get(context).posts.length}',
                        style: const TextStyle(
                            color: Colors.white,
                          fontSize: 15
                        ),
                      ),
                      const Text('Posts',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15
                        ),),
                    ],
                  ),
                ),
                 Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${SocialLayoutCubit.get(context).posts.length}',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15
                          ),
                      ),
                      const Text('Photos', style: TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      ),),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
            cubit?.name ?? ''
            ,style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              cubit?.bio ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            style: BorderStyle.solid,
                          color: Colors.white
                        )
                    ),
                    child: MaterialButton(onPressed: (){
                      CacheHelper.removeData(key: 'uId');
                      navigateAndFinish(context, LoginScreen());
                    },child:
                    const Row(
                      children: [
                        Text(
                          'Sign Out',style: TextStyle(
                            fontSize: 15,
                          color: Colors.white
                        ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                          Icons.arrow_back_ios_new_outlined,
                            color: Colors.white
                        )
                      ],
                    )
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    width: 180,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: Colors.white
                        )
                    ),
                    child: MaterialButton(onPressed: (){
                      navigateTo(context, EditProfileScreen());
                    },child:
                    const Row(
                      children: [
                        Text(
                          'Edit Profile',style: TextStyle(
                            fontSize: 15,
                            color: Colors.white
                        ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Icon(
                            Icons.auto_fix_high_outlined,
                            color: Colors.white
                        )
                      ],
                    )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            if (SocialLayoutCubit.get(context).posts.isNotEmpty)
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context,index) => postMyItem(context,SocialLayoutCubit.get(context).socialUserModel!,SocialLayoutCubit.get(context).posts[index],index),
                  separatorBuilder: (context,index) => const SizedBox(height: 10,),
                  itemCount: SocialLayoutCubit.get(context).posts.length,
                ),
              ),
          ],
        ),
      ),
      listener: (context,state){},
    );
  }
}

Widget postMyItem(context,SocialUserModel userModel,SocialPostModel postModel,index) => Card(
  color: HexColor('333739'),
  elevation: 5,
  margin: const EdgeInsets.symmetric(horizontal:8 ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 5,
        ),
        Text(
          '${postModel.text}',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(
          height: 10,
        ),
        if (postModel.postImage != '' )
          Container(
            height: 300,
            width: double.infinity,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image:  DecorationImage(
                  image: NetworkImage('${postModel.postImage}'),
                  fit: BoxFit.cover),
            ),
          ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            InkWell(
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      '${SocialLayoutCubit.get(context).likes[index]}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      )
                  ),
                ],
              ),
              onTap: ()
              {

              },
            ),
            const Spacer(),
            InkWell(
              child: Row(
                children: [
                  const Icon(CupertinoIcons.text_bubble,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                      '${SocialLayoutCubit.get(context).commentId[index]} comments',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15
                      )
                  )
                ],
              ),
              onTap: (){
                navigateTo(context, CommentScreen());
                SocialLayoutCubit.get(context).fetchCommentsForPost(SocialLayoutCubit.get(context).postsId[index]);
              },
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  ),
);