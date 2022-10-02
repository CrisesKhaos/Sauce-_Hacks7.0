// import 'dart:io';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:uuid/uuid.dart';

// class NewPostImagePage extends StatefulWidget {
//   NewPostImagePage();
//   @override
//   _NewPostImagePageState createState() => _NewPostImagePageState();
// }

// class _NewPostImagePageState extends State<NewPostImagePage> {
//   final uuid = Uuid();
//   late String url;
//   TextEditingController captioncont = new TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     if (url == null) uploadImage();
//     print(url);
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.check),
//             onPressed: () async {
//               if (url != null) {
//                 //toHomePage
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => HomePage()),
//                 );
//               }
//             },
//           )
//         ],
//       ),
//       body: ListView(
//         children: [
//           if (url != null)
//             Card(
//               elevation: 5,
//               color: Colors.pinkAccent[50],
//               child: Padding(
//                 padding: EdgeInsets.all(4),
//                 child: Image.network(url),
//               ),
//               margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
//             )
//           else
//             Placeholder(
//               color: Colors.black,
//             ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: TextField(
//               minLines: 5,
//               maxLines: 5,
//               controller: captioncont,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                     borderSide: BorderSide(width: 5, color: Colors.yellow)),
//                 labelText: 'Enter a caption',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void uploadImage() async {
//     var postUrl;
//     final _imgpicker = ImagePicker();
//     PickedFile image;

//     //var file = File(image.path);
//   }
// }
