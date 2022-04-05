// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:relis/globals.dart';

// class ViewButton extends StatefulWidget {
//   String containerName;
//   String visibilityName;
//   Widget containerChild;
//   ViewButton(this.containerName, this.visibilityName, this.containerChild);

//   @override
//   _ViewButtonState createState() => _ViewButtonState();
// }

// class _ViewButtonState extends State<ViewButton> {

//   @override
//   void initState() {
//     super.initState();
//     print("In ViewButton of ${widget.containerName}");
//   }

//   @override
//   void dispose() {
//     print("Out ViewButton of ${widget.containerName}");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("viewButton - ${widget.containerName}");
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           MaterialButton(
//             splashColor: Color(0xff014b76),
//             onPressed: (){
//               visible[widget.visibilityName] = !visible[widget.visibilityName]!;
//               setState(() {});
//             },
//             child: Container(
//               alignment: Alignment.centerLeft,
//               height: 50,
//               padding: EdgeInsets.symmetric(vertical: 10.00, horizontal: 40.00),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     visible[widget.visibilityName]! ? Icons.keyboard_arrow_down_rounded : Icons.play_arrow_rounded,
//                     size: 30,
//                   ),
//                   SizedBox(width: 20.00,),
//                   Text(widget.containerName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
//                 ],
//               ),
//             ),
//           ),
//           Visibility(
//             visible: visible[widget.visibilityName]!,
//             child: widget.containerChild,
//           ),
//         ],
//     );
//   }
// }