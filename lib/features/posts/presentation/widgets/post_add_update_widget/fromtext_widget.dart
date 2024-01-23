import 'package:flutter/material.dart';

class TextFromWidget extends StatelessWidget {
  const TextFromWidget(
      {super.key,
      required this.bodyControll,
      required this.text,
      required this.minline,
      required this.maxline});
  final TextEditingController bodyControll;
  final String text;
  final int minline;
  final int maxline;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: bodyControll,
      validator: (value) {
        if (value!.isEmpty) return " $text Canot be Empty";
        return null;
      },
      decoration: InputDecoration(border: OutlineInputBorder(), hintText: text),
      maxLines: maxline,
      minLines: minline,
    );
  }
}
