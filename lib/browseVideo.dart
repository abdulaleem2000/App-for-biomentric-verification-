//import 'dart:html';

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
      appBar: AppBar(title: Text("Upload Video"),),
      body: uploadVideo(),
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
   String PersonName ="Pino";
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
  final request = http.MultipartRequest("POST", Uri.parse("http://9c14-34-80-206-184.ngrok.io/upload"));
  final header = {"Content-type" : "multipart/form-data"};

  request.files.add(
    http.MultipartFile('file', _video!.readAsBytes().asStream(), _video!.lengthSync(),
      filename: _video!.path.split('/').last));

  request.headers.addAll(header);
  final response = await request.send();
  http.Response res = await http.Response.fromStream(response);
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
        Center(child: Text("Uplod video")),

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
              Text("Video has not choosen yet"),

          ],
        ),
    ),

        TextButton(onPressed: () {
          _pickVideo();
        },
            child: Text("Browse Video from Mobile")),

        TextButton(onPressed: () {
          uploadImage();



        }, child: Text("Send File")),

        TextButton(onPressed: () async {
          final respose = await http.get(Uri.parse('http://9c14-34-80-206-184.ngrok.io/result'));
          final decode = json.decode(respose.body) as Map<String, dynamic>;

          setState(() {
            PersonName = decode['result'];
            print(PersonName);
          });
        }, child: Text("Cheak")),

        Text(PersonName),

      ],

    );
  }
}



