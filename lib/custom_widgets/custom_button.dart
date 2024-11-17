import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()?onTap;
  final Color?backgroundColor;
  final Color?textColor;
  const CustomButton({super.key, required this.title, this.onTap, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal:5,vertical: 20),
        decoration: BoxDecoration(
          color:backgroundColor==null? Colors.indigo:null,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(title,style:  TextStyle(
              color:textColor==null? Colors.white:Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 26
          ),),),
        ),
      ),
    );
  }
}
