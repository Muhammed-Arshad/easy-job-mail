import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'button.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final int maxLines;
  const CustomTextField({super.key,
    required this.label,
    this.maxLines = 1});

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
            Text(label),
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
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.green, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.green, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
