//import 'dart:html';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import 'package:http/http.dart' as http;

class BrowseVideo extends StatefulWidget {
  const BrowseVideo({Key? key}) : super(key: key);

  @override
  State<BrowseVideo> createState() => _BrowseVideoState();
}

class _BrowseVideoState extends State<BrowseVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Video", style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.blue[200],),
      body: uploadVideo(),
        backgroundColor: Colors.blue[100],
    );



  }
}

class uploadVideo extends StatefulWidget {
  const uploadVideo({Key? key}) : super(key: key);

  @override
  State<uploadVideo> createState() => _uploadVideoState();
}

class _uploadVideoState extends State<uploadVideo> {


  @override
  void initState(){
    super.initState();
    // controller = VideoPlayerController.
  }
//
   FilePickerResult ? result;
//   String? _fileName;
   PlatformFile? pickedfile;
   File ? files;
   String PersonName =" ";
// bool isLoading = false;
// File?fileToDisplay;
//   File? _selectedVideo;
//
//
//

//
//   Future<void> pickfile() async {
//     try {
//       setState(() {
//         isLoading =true;
//       });
//       result = await FilePicker.platform.pickFiles(
//         type:FileType.video,
//         allowMultiple: false,
//       );
//       if(result != null){
//           _fileName = result!.files.first.name;
//           pickedfile = result!.files.first;
//          // fileToDisplay = File(pickedfile.path.toString());
//       }
//     }
//     catch(e){
//       print(e);
//     }

    //return File(result.files.single.path);
 // }



  File ? _video;
  late VideoPlayerController _videoPlayerController;
//  late String _video1;
final picker = ImagePicker();
String ? message = "";

_pickVideo() async{
   final video = await picker.pickVideo(source: ImageSource.gallery);
  _video = File(video!.path);
  print("-----------------------------------");
  print(_video);
  print(video.name);
  print(video.path);
  print(video);
   print("---------------------------------");
  _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_)  {
  setState(() {

  });
  _videoPlayerController.play();
});


}


uploadImage() async {
  final request = http.MultipartRequest("POST", Uri.parse("http://134a-35-196-97-8.ngrok.io/upload"));
  final header = {"Content-type" : "multipart/form-data"};

  request.files.add(
    http.MultipartFile('file', _video!.readAsBytes().asStream(), _video!.lengthSync(),
      filename: _video!.path.split('/').last));

  request.headers.addAll(header);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);
  print("++++++++=============================++++++++++++++++++++");
  final resJson = jsonDecode(res.body);
  message = resJson['message'];
  print('-----------------------message------------------');
  print(message);
  print('----------------------messageq-------------------');

  setState(() { });
}

  @override
  Widget build(BuildContext context) {

    return Column(





      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Center(child: Text("Uplod video")),

        SizedBox(
    width: 300,
          height: 300,

        child: Column(
          children: [
            if(_video != null)
              _videoPlayerController.value.isInitialized ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,

                child: VideoPlayer(_videoPlayerController),
              ) : Container()
            else
              Text("Video hasn't been chosen yet"),

          ],
        ),
    ),

        TextButton(
            style: ButtonStyle(
             // backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),
        ),
            onPressed: () {
          _pickVideo();
        },
             child: Container(
               margin: EdgeInsets.only(right: 50, left: 50),
               padding: EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: Colors.blue[200],

               ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Icon(EvaIcons.cloudUpload,size: 32,color: Colors.black,),
                    SizedBox(width: 5,),
                  Text("Browse Video from Mobile",
                    style: TextStyle(color: Colors.black,
                    fontSize: 16,
                    ),),

                ],
              ),
             )
              ),

       //
       //  TextButton(onPressed: () {
       // //   uploadImage();
       //
       //
       //
       //  }, child: Text("Send File")),

        TextButton(onPressed: ()  {

         uploadImage();




        },
            child: Container(
              margin: EdgeInsets.only(right: 50, left: 50),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
               // border: Color.black,
                color: Colors.blue[200],

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(FeatherIcons.send, size: 32,color: Colors.black,),
                   SizedBox(width: 10,),
                  Text("Send Video", style: TextStyle(color: Colors.black, fontSize: 22),),
                ],
              ),
            )),

        TextButton(onPressed: () async {

      //    uploadImage();


          final respose = await http.get(Uri.parse('http://134a-35-196-97-8.ngrok.io/result'));
          final decode = json.decode(respose.body) as Map<String, dynamic>;

          setState(() {
            PersonName = decode['result'];
            print(PersonName);
          });
        },
            child: Container(
              margin: EdgeInsets.only(right: 50, left: 50),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                // border: Color.black,
                color: Colors.blue[200],

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(FeatherIcons.checkCircle, size: 32,color: Colors.black,),
                  SizedBox(width: 10,),
                  Text("Verify Person", style: TextStyle(color: Colors.black, fontSize: 22),),
                ],
              ),
            )),


        Container(
            child: Center(child: Text(PersonName, style: TextStyle(fontSize: 32),))
        ),

      ],

    );
  }
}



