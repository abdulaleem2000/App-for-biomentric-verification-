import 'package:flutter/material.dart';
import 'package:ppgbio/Dashbord.dart';
import 'package:ppgbio/browseVideo.dart';




class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PPG Bio"),
        
      ),
      body: childWiget(),

    );
  }
}

class childWiget extends StatefulWidget {
  const childWiget({Key? key}) : super(key: key);

  @override
  State<childWiget> createState() => _childWigetState();
}

class _childWigetState extends State<childWiget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          Container(child: Center(child: Text("Don,t forget to Turn On Flash Light"))),

          Container(
            child: Center(child: Text("Fadsjfkdfnaskjfkaahfjksdhjkfhjkahfdkjshjafhkj")),
          width: MediaQuery.of(context).size.width * .7,
          ),



          TextButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>BrowseVideo()));

            print("hello Button Pressed");
          }, child: Text("Upload "))
        ],
      ),
    );
  }
}



