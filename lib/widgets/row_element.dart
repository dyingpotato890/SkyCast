import 'package:flutter/material.dart';

class RowElement extends StatelessWidget {
  final String title;
  final String value;
  final String element;

  const RowElement({
    super.key,
    required this.title,
    required this.value,
    required this.element,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(element, scale: 8),

        SizedBox(width: 5),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}