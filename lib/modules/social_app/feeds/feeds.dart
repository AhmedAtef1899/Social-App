import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/comment_model.dart';
import 'package:login/models/social_app/post_model.dart';
import 'package:login/models/social_app/social_user_model.dart';
import 'package:login/modules/social_app/feeds/comment_screen.dart';
import 'package:login/shared/components/components.dart';

class FeedsScreen extends StatelessWidget {

  FeedsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialLayoutCubit,SocialLayoutStates>
      (
        builder: (context,state) =>SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              if (state is SocialLayoutGetPostLoadingState)
                const Center(child: CircularProgressIndicator()),
              if (SocialLayoutCubit.get(context).posts.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index) => postItem(context,SocialLayoutCubit.get(context).socialUserModel!,SocialLayoutCubit.get(context).posts[index],index),
                  separatorBuilder: (context,index) => const SizedBox(height: 10,),
                  itemCount: SocialLayoutCubit.get(context).posts.length,
                ),
              if (SocialLayoutCubit.get(context).posts.isEmpty)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
        listener: (context,state){}
    );
  }
}

Widget postItem(context,SocialUserModel userModel,SocialPostModel postModel,index) => Card(
  color: HexColor('333739'),
  elevation: 5,
  margin: const EdgeInsets.symmetric(horizontal:8 ),
  clipBehavior: Clip.antiAliasWithSaveLayer,
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                backgroundImage:
                NetworkImage('${postModel.image}')
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${postModel.name}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '${DateTime.now()}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11
                      ),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: (){}, icon: const Icon(
                Icons.more_horiz
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
              bottom: 5,
              top: 5
          ),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '${postModel.text}',
          style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
        // Container(
        //   width: double.infinity,
        //   child: Wrap(
        //     children: [
        //       MaterialButton(onPressed: (){},
        //         minWidth: 1,
        //         padding: const EdgeInsetsDirectional.only(
        //             end: 6
        //         ), child: const Text(
        //           '#software',
        //           style: TextStyle(
        //               color: defaultColor
        //           ),
        //         ),
        //       ),
        //       MaterialButton(onPressed: (){},
        //         minWidth: 1,
        //         padding: const EdgeInsetsDirectional.only(
        //             end: 10
        //         ), child: const Text(
        //           '#flutter',
        //           style: TextStyle(
        //               color: defaultColor
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(
          height: 10,
        ),
        if (postModel.postImage != '' )
          Container(
            height: 350,
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
                        fontSize: 13
                    ),
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
                        fontSize: 13
                    ),
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
        Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[600],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
             CircleAvatar(
              backgroundImage: NetworkImage('${userModel.image}'),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: InkWell(
                onTap: (){
                  navigateTo(context, CommentScreen());
                  SocialLayoutCubit.get(context).fetchCommentsForPost(SocialLayoutCubit.get(context).postsId[index]);
                },
                child: const Text(
                  'Write a comment...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                  ),
                ),
              )
            ),
            const SizedBox(
              width:95,
            ),
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                     Icon(
                        Icons.favorite_border,
                      color: SocialLayoutCubit.get(context).colorIcon? Colors.red: Colors.white ,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      'Like', style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                    ),
                    ),
                  ],
                ),
                onTap: (){
                  SocialLayoutCubit.get(context).likePost(SocialLayoutCubit.get(context).postsId[index]);
                  SocialLayoutCubit.get(context).changeColor();

                },
              ),
            )
          ],
        )
      ],
    ),
  ),
);
