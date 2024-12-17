import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestionButton extends StatelessWidget {
  final String content;
  final Color btnColor;
  const SuggestionButton({super.key,
  required this.content,
  this.btnColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: btnColor,
        // shadowColor: Colors.greenAccent.shade200,
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0)),
        minimumSize: const Size(50, 30), //////// HERE
      ),
      onPressed: () {},
      child: Text(content),
    );
  }
}

class MainButton extends StatelessWidget {
  final VoidCallback onTap;
  const MainButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          foregroundColor: Colors.white, backgroundColor:Colors.blue.shade300,
          minimumSize: const Size(double.infinity, 45),
        ),
        onPressed: onTap, child: const Text('Send'));
  }
}

class SecondaryButton extends StatelessWidget {
  final VoidCallback onTap;
  const SecondaryButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.blue,
          elevation: 3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          minimumSize: const Size(50, 35)
      ),
      onPressed: onTap,
      child: const SizedBox(
        height: 35,
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.upload),
            Text('attachment'),
          ],
        ),
      ),
    );
  }
}

