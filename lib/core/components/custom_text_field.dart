import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:quran_app/constant/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.sendOnPressed,
      this.hintText,
      this.controller,
      this.onChanged});

  final void Function()? sendOnPressed;
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 17,
        fontFamily: 'Cairo',
      ),
      controller: controller,
      cursorWidth: 0,
      decoration: InputDecoration(
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(8),
        fillColor: const Color(0xfffaf9f6),
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: 'Cairo',
        ),
        suffixIcon: Icon(
          Iconsax.search_normal_outline,
          color: fiveColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: fiveColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: fiveColor,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}
