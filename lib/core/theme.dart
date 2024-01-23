import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData();
final ThemeData DarkTheme = ThemeData();

Widget Divider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 25.0),
      child: Container(
        width: 1.0,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );
