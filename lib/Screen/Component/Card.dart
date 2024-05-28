import 'package:flutter/material.dart';

class CustomeCard extends StatelessWidget {
  const CustomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: const Text(
        "Smartphones",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
