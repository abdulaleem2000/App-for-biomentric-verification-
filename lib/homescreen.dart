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
        title: Center(
            child: Text("PPG Bio", style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)),
        backgroundColor: Colors.blue[200],
      ),
      body: childWiget(),
       backgroundColor: Colors.blue[100],

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(
                left: 25,right: 25, top: 55, bottom: 35),

              //margin: EdgeInsets.all(20),

              
              child: Center(
                  child: Text("This Application is used for the Verification "
                      "of Persons. This Application take a video from Mobile Phone Local Stroage and "
                      "compare with ML Model",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                     // fontWeight: FontWeight.bold,
                    ),
                  )
              ),
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),

              )
            ),

          ),

          Container(
            
         //   margin: EdgeInsets.all(30),
            margin: EdgeInsets.only(bottom: 45, right: 28, left: 28),
            child: TextButton(
              
        style: ButtonStyle(
            // : EdgeInsets.all(30),
            //backgroundColor: MaterialStateColor.resolveWith((states) => Colors.redAccent),

        ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BrowseVideo()));

                  print("hello Button Pressed");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Let's Get Started",
                    style: TextStyle(
                      fontSize: 35,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black54
                    ),),
                    Icon(
                      Icons.arrow_forward,
                      size: 32,
                    ),
                    
                  ],
                )),
          ),


        ],
      ),
    );
  }
}
