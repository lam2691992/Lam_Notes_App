import 'dart:io';
import 'package:flutter/material.dart';
import 'home_Screen.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Lấy đường dẫn thư mục ứng dụng để lưu trữ dữ liệu của Hive
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();

    // Truyền đường dẫn thư mục ứng dụng vào Hive.init()
    Hive.init(appDocumentDirectory.path);

    await Hive.openBox('Notes_box');
  } catch (e) {
    // ignore: avoid_print
    print('Error initializing Hive: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
