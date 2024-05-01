import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';

class NewPostScreen extends StatelessWidget {

  var postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        builder: (context,state) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Create Post',
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                    right: 15
                ),
                child: TextButton(onPressed: (){
                  var now = DateTime.now();
                  if (SocialLayoutCubit.get(context).postImage == null)
                  {
                    SocialLayoutCubit.get(context).createPostData(
                        text: postController.text, date: now.toString()
                    );
                  }
                  else
                  {
                    SocialLayoutCubit.get(context).createPost(text: postController.text,
                        date: now.toString()
                    );
                  }
                  postController.clear();
                },
                  child: const Text(
                    'POST',style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16
                  ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state is SocialLayoutCreatePostLoadingState )
                    const LinearProgressIndicator(),
                  Row(
                    children: [
                       CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            '${SocialLayoutCubit.get(context).socialUserModel?.image}'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${SocialLayoutCubit.get(context).socialUserModel?.name}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: postController,
                    decoration:  InputDecoration(
                      hintText: 'what is on your mind, ${SocialLayoutCubit.get(context).socialUserModel?.name}?',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic
                    ),
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  if (SocialLayoutCubit.get(context).postImage != null)
                    Card(
                      elevation: 10,
                      clipBehavior:Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.all(8),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [ Image(image:
                        FileImage(SocialLayoutCubit.get(context).postImage!),
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                          IconButton(onPressed: (){SocialLayoutCubit.get(context).removeImagePost();}, icon: const Icon(
                            Icons.close
                          ))
                        ]
                      ),
                    ),
                  InkWell(
                    onTap: (){
                      SocialLayoutCubit.get(context).pickPostImage();
                    },
                    child:  const Row(
                        children: [
                          Icon(
                            Icons.image_outlined,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                           Text(
                            'ADD PHOTOS',
                            style: TextStyle(
                                color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ]
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        listener: (context,state){});
  }
}
