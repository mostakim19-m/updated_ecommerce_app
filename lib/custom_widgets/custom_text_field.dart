import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
 final String? hintText;
 final String ? labelText;
 final Widget? suffixIcon;
 final TextEditingController?controller;
 final TextInputType?keyBoardType;
 final bool ?obscureText;
 final void Function()?onTap;


 const  CustomTextField({super.key, this.hintText, this.labelText, this.suffixIcon, this.controller, this.keyBoardType, this.obscureText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      keyboardType: keyBoardType,
      obscureText: obscureText??false,
      validator: (value) {
        if(value==null|| value.isEmpty){
          return 'This is Required';
        }
        return null;
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.black,
              width:1
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.indigo,
              width: 2
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Colors.red,
              width: 2
          ),
        ),
        hintText: hintText,
        hintStyle:  const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16
        ),
        label:labelText!=null?  Text(labelText!,style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo
        ),):null,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
