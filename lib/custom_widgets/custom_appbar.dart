import 'package:flutter/material.dart';
PreferredSizeWidget customAppBar({
  String? title,
  List<Widget>?action,
  Widget?leading,
  Color ? backgroundColor,
}){
  return AppBar(
    backgroundColor: backgroundColor,
    leading: leading ?? IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
    title:title!=null? Text(title,style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),):null,
    actions:action,
    centerTitle: true,
  );
}