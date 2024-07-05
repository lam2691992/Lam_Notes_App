import 'package:flutter/material.dart';

mixin ThemeUtil<T extends StatefulWidget> on State<T> {
  ThemeData get theme => Theme.of(context);
}
