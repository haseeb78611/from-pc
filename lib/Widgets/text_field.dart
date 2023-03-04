import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String? hintText;
  final String? suffixText;
  final validatorMsg;
  final onTap;
  final maxLines;

  const MyTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.suffixText,
    this.validatorMsg,
    this.onTap,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      decoration:InputDecoration(hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          contentPadding: EdgeInsets.all(10),
          suffixText: suffixText,

      ),
      autofocus: false,
      validator: (value) {
        if(value!.isEmpty){
          return validatorMsg!;
        }
      },
      onTap:  onTap,
    );
  }
}
