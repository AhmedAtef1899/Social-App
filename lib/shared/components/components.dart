

import 'package:flutter/material.dart';




Widget defaultButton ({
  double width = double.infinity,
  Color background = Colors.black,
  double radius = 10.0,
  required String text,
  required Function() function,
}) => Container(
  width: width,
  height: 50,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
  child: MaterialButton(onPressed: function,
    child:
   Text(
    '$text',style: const TextStyle(
    fontSize: 20,
    color: Colors.white,
  ),
  ),
  ),
);

Widget defaultForm({

  required String label,
  required IconData prefix,
  required TextInputType type,
  required TextEditingController controller,
  required FormFieldValidator validate,
  Function()? onTap,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function(String value)? onSubmit,
  bool enable = true,
  dynamic onChange,
})=>TextFormField(
  decoration:  InputDecoration(
    labelText: label,

    prefixIcon: Icon(

      prefix

    ),

    suffixIcon: IconButton(onPressed: suffixPressed, icon:

      Icon(

        suffix

      )

    ),

    border: const OutlineInputBorder(),

  ),

  onFieldSubmitted: onSubmit,

  obscureText: isPassword,

  keyboardType: type,

  controller: controller,

  validator: validate,

  onTap: onTap,

  enabled: enable,

  onChanged: onChange,

);


Widget tasksItem(Map model,context) => Dismissible(
  key:Key(model['id'].toString()),
  onDismissed: (direction){
    // AppCubit.get(context).deleteDatabase(id: model['id'],);
  },
  child:  Padding(
    padding: const EdgeInsets.all(20),

    child: Column(

      children: [

        Row(

          children:  [

            CircleAvatar(

              radius: 40,

              child: Text(

                  '${model['time']}'

              ),

            ),

            const SizedBox(

              width: 15,

            ),

            Column(

              children:  [

                Text(

                  '${model ['title']}',style: const TextStyle(

                    fontSize: 25,fontWeight: FontWeight.bold

                ),

                ),

                Text(

                    '${model ['date']}'

                ),

              ],

            ),

            const SizedBox(

              width: 20,

            ),

            IconButton(onPressed: (){

              // AppCubit.get(context).tasks.forEach((element) {
              //   AppCubit.get(context).done.add(element);
              // });
            }, icon:
            const Icon(

              Icons.check_circle,color: Colors.green,

            )),

            const SizedBox(

              width: 20,

            ),

            IconButton(onPressed: (){
              // AppCubit.get(context).tasks.forEach((element) {
              //   AppCubit.get(context).archived.add(element);
              // });

            }, icon:

            const Icon(

              Icons.archive,color: Colors.black45,

            )),

          ],

        )

      ],

    ),

  ),

);
Widget testItem(Map model,context) => Padding(
  padding: const EdgeInsets.all(20),

  child: Column(

    children: [

      Row(

        children:  [

          CircleAvatar(

            radius: 40,

            child: Text(

                '${model['type']}'

            ),

          ),

          const SizedBox(

            width: 15,

          ),



        ],

      )

    ],

  ),

);

// Widget businessItem(article,context)=>InkWell(
//   onTap: (){
//     navigateTo(context, webView(url: '${article['url']}'));
//   },
//   child:   Padding(
//
//     padding: const EdgeInsets.all(20),
//
//     child: Row(
//
//       children: [
//
//         Container(
//
//           width: 120,
//
//           height: 120,
//
//           decoration: BoxDecoration(
//
//               borderRadius: BorderRadius.circular(10),
//
//               image:  DecorationImage(image:
//
//               NetworkImage('${article ['urlToImage']}'),
//
//                   fit: BoxFit.cover
//
//               )
//
//           ),
//
//         ),
//
//         const SizedBox(
//
//           width: 20,
//
//         ),
//
//         Expanded(
//
//           child: Container(
//
//             height: 120,
//
//             child: Column(
//
//               crossAxisAlignment: CrossAxisAlignment.start,
//
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               children:  [
//
//                 Expanded(
//
//                   child: Text(
//
//                     '${article['title']}',style: Theme.of(context).textTheme.bodyText1,
//
//                     maxLines: 3,
//
//                     overflow: TextOverflow.ellipsis,
//
//                   ),
//
//                 ),
//
//                 Text(
//
//                   '${article ['publishedAt']}',style: const TextStyle(fontSize: 15,color: Colors.grey),
//
//                 ),
//
//               ],
//
//             ),
//
//           ),
//
//         )
//
//       ],
//
//     ),
//
//   ),
// );

Widget line()=> Padding(
  padding: const EdgeInsets.all(20),
  child:   Container(
    height: 1,
    color: Colors.grey[600],
  ),
);

void navigateTo(context,widget) =>   Navigator.push(
context,
MaterialPageRoute(builder:
(context)=> widget)) ;

void navigateAndFinish(context,widget) =>   Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder:
        (context)=> widget),
    (route){
      return false;
    }
) ;

// void showToast({required String msg, ToastState? state}) =>  Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_LONG,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 5,
//     backgroundColor: chooseToastColor(state!),
//     textColor: Colors.white,
//     fontSize: 16.0
// );

//enum

enum ToastState {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastState state){
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color = Colors.green;
      break;
    case ToastState.ERROR:
      color =  Colors.red;
      break;
    case ToastState.WARNING:
      color =  Colors.amber;
      break;
  }
  return color;
}





