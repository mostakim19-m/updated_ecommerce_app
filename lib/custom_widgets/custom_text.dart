import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final String subtitle;
  const CustomText({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,style: const TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 45
        ),),
        const SizedBox(height: 20,),
        Text(subtitle,style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),textAlign: TextAlign.center,),
      ],
    );
  }
}
