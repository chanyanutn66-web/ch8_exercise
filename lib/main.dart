// ใน lib/main.dart
import 'package:flutter/material.dart';
import 'login_form_screen.dart'; // Import หน้าจอฟอร์ม

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginFormScreen(), // ตั้ง LoginFormScreen เป็น home
    );
  }
}