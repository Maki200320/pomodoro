import 'package:flutter/material.dart';

class clockPad extends StatefulWidget {
  final double width;
  final Color color;



  // Constructor
  const clockPad({
    Key? key,
    required this.width,
    required  this.color,


     // Default value for height
  }) : super(key: key);


  @override
  State<clockPad> createState() => _clockPadState();
}

class _clockPadState extends State<clockPad> {
  @override
  Widget build(BuildContext context) {

    var orientation = MediaQuery.of(context).orientation;

    //size of the window
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var  width = size.width;

    return Scaffold(

      body:Container(
        width: width  / 5,
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: Text("00", style: TextStyle(
            fontSize: 80,
          ),),
        ),
      ),
    );
  }
}
