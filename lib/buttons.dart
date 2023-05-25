import 'package:flutter/material.dart';
class MyButton extends StatelessWidget {

  final color;
  final textcolor;
  final  buttonText;
  final  buttonTapped;

  MyButton({this.color,this.textcolor,this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          child: Container(
            decoration:BoxDecoration(borderRadius: BorderRadius.circular(50.0), color: color) ,

            child: Center(
              child:  Text(buttonText, style: TextStyle(color: textcolor, fontSize: 20), ),
            ),
          ),
          ),
      ),
    );
  }
}

