import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Center(
          child: SizedBox(
              height: 30.0,
              width: 30.0,
              child: CircularProgressIndicator(
                color: Colors.blue[400],
              ))),
    );
  }
}
