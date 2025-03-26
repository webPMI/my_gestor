import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
const MyButton({ super.key, this.text, this.onPressed, this.width, this.height, this.padding, this.margin });
final String? text;
final Function()? onPressed;
final double? width;
final double? height, padding, margin; 
  @override
  Widget build(BuildContext context){
    return Container(
      width: width,
      height: height,
      padding:  EdgeInsets.all(padding??0),
      margin:  EdgeInsets.all(margin??0),
      child: ElevatedButton(
        onPressed:onPressed?? () {  },
        child: Text(text??'Enter'),
      ),
    );
  }
}