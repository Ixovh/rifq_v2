import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeButtonWidgets extends StatelessWidget{
  final String titel ;
  final VoidCallback onPressed;
  final double buttonWidth;
  final double buttonhight;

  const CustomeButtonWidgets({super.key, required this.titel, required this.onPressed, required this.buttonWidth, required this.buttonhight});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(buttonWidth, buttonhight),
          backgroundColor: Color(0xFF3AB7A5),),
        child: Text(titel,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp),));
  }
}
