import 'package:flutter/material.dart';

class TopBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const TopBorderButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.orangeAccent, // Change color as needed
              width: 2.0, // Change width as needed
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Change text color as needed
              ),
            ),
          ),
        ),
      ),
    );
  }
}
