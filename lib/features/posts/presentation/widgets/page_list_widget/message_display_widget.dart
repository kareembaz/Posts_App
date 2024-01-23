import 'package:flutter/material.dart';

/// to print the error empty when the cach is Empty to show  the print messgae error
class MessageDisplayWidget extends StatelessWidget {
  const MessageDisplayWidget({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(
            message,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
