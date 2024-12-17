import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController ctrl;
  final String label;
  final int maxLines;
  const CustomTextField({super.key,
    required this.label,
    this.maxLines = 1, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 20,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,style: TextStyle(fontWeight: FontWeight.w500),),
            label == 'Email:'?
                const Row(
                  spacing: 5,
                  children: [
                    SuggestionButton(content: '@gmail.com'),
                    SuggestionButton(content: '@hotmail.com')
                  ],
                ):const SuggestionButton(content: 'last used',
              btnColor: Colors.blue,),
          ],
        ),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.blue.shade300, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
