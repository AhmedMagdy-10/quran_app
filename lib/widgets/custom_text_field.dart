import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, this.sendOnPressed, this.hintText, this.controller});

  final void Function()? sendOnPressed;
  final String? hintText;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        textDirection: TextDirection.rtl,
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: const Icon(Icons.search),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: InputBorder.none),
      ),
    );
  }
}
