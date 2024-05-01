import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/layout/social-app/cubit/cubit.dart';
import 'package:login/layout/social-app/cubit/state.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialLayoutCubit,SocialLayoutStates>(
        builder: (context,state)=> Scaffold(
          appBar: AppBar(),
          body:   Stack(
            alignment: Alignment.topRight,
            children: [
              Image(
                image: FileImage(SocialLayoutCubit.get(context).messageImage!),
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              IconButton(onPressed: (){
                SocialLayoutCubit.get(context).removeImage();
              }, icon: const Icon(
                  Icons.close
              ))
            ],
          ),
        ),
        listener: (context,state){}
    );
  }
}
