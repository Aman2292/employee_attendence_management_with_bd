import 'package:flutter/material.dart';

Widget iconWithDivider(IconData icon) {
  return Container(
    width: 55,
    padding: const EdgeInsets.only(left: 12, right: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20),
        const VerticalDivider(
          thickness: 1,
          width: 8,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ],
    ),
  );
}
