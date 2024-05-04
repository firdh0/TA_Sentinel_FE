import 'package:chat_armor/shared/theme.dart';
import 'package:flutter/material.dart';

class CustomFormFilled  extends StatelessWidget {

  final String title;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomFormFilled ({
    Key? key,
    required this.title,
    this.obscureText = false,
    this.controller,
    this.keyboardType
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontWeight: medium,
          ),
        ),

        const SizedBox(
          height: 8,
        ),

        TextFormField(
          obscureText: obscureText,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }
}