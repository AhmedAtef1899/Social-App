

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';

class EditProfileScreen extends StatelessWidget {
  var bioController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = SocialLayoutCubit.get(context).socialUserModel;
    nameController.text = cubit?.name ?? '';
    bioController.text = cubit?.bio ?? '';
    phoneController.text = cubit?.phone ?? '';
    return BlocConsumer<SocialLayoutCubit,SocialLayoutStates>
      (builder: (context,state) => Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 15),
            child: IconButton(onPressed: (){
              SocialLayoutCubit.get(context).uploadImageToStorage
                (
                  name: nameController.text,
                  bio: bioController.text,
                phone: phoneController.text
              );
            }, icon:
            const Icon(
              Icons.done,
              color: Colors.blue,
              size: 30,
            )
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children:
                  [
                    SocialLayoutCubit.get(context).image != null?
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(SocialLayoutCubit.get(context).image!),
                      ) : CircleAvatar(
                        radius: 80,
                        backgroundImage:NetworkImage(cubit?.image ?? ''),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.blue[100],
                        child: IconButton(onPressed: (){
                          SocialLayoutCubit.get(context).pickImage();
                        }, icon:
                        const Icon(
                          Icons.camera_alt_outlined,
                        )
                        ),
                      )
                  ]
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameController,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                      {
                        return 'Empty';
                      }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.person_outlined
                    ),
                    label: Text(
                        'Name',
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.info_outline
                    ),
                    label: Text(
                        'Bio',
                        style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                        Icons.call_outlined
                    ),
                    label: Text(
                        'Phone',
                        style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
        listener: (context,state){}
    );
  }
}
