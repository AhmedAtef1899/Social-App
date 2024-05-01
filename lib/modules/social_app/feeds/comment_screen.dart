import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';
import 'package:login/models/social_app/comment_model.dart';

class CommentScreen extends StatelessWidget {
  var commentController = TextEditingController();

  CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialLayoutCubit, SocialLayoutStates>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => commentPost(
                    context,
                    SocialLayoutCubit.get(context).comments[index],
                  ),
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 50),
                  itemCount: SocialLayoutCubit.get(context).comments.length,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              commentField(context),
            ],
          ),
        ),
      ),
      listener: (context, state) {},
    );
  }

  Widget commentPost(context, SocialCommentModel commentModel) => Column(
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('${SocialLayoutCubit.get(context).socialUserModel?.image}'),
          ),
          const SizedBox(
            width: 15,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[700],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' ${SocialLayoutCubit.get(context).socialUserModel?.name}',
                    style: const TextStyle(
                      color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    )
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    '  ${commentModel.comment}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );

  Widget commentField(context) => SizedBox(
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: commentController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Write a comment',
              hintStyle:  TextStyle(
                color: Colors.white,
                fontSize: 15,
            ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            String commentText = commentController.text;
            if (commentText.isNotEmpty) {
              SocialLayoutCubit.get(context).commentOnPost(
                SocialLayoutCubit.get(context).postsId[0], // Assuming you want to comment on the first post
                commentText,
              );
              commentController.clear();
            }
          },
          icon: const Icon(Icons.send_outlined),
            color: Colors.white,
        ),
      ],
    ),
  );
}
