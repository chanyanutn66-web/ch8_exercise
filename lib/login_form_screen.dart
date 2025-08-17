import 'package:flutter/material.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  String _savedEmail = '';
  String _savedPassword = '';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ฟอร์มล็อกอิน')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'กรุณาป้อนข้อมูลเข้าระบบ:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // ปุ่มล็อกอิน (ย้ายมาไว้ข้างล่าง)
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'ล็อกอินสำเร็จ! อีเมล: $_savedEmail, รหัสผ่าน: $_savedPassword',
                        ),
                      ),
                    );
                    print('อีเมลที่บันทึก: $_savedEmail');
                    print('รหัสผ่านที่บันทึก: $_savedPassword');
                  } else {
                    print('ฟอร์มไม่ถูกต้อง');
                  }
                },
                child: const Text('ล็อกอิน'),
              ),
              // ฟิลด์ Email
              TextFormField(
                onSaved: (value) {
                  if (value != null) {
                    _savedEmail = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนอีเมลของคุณ';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'กรุณาป้อนที่อยู่อีเมลที่ถูกต้อง';
                  }
                  return null;
                },
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'อีเมล',
                  hintText: 'you@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 15),

              // ฟิลด์ Password
              TextFormField(
                onSaved: (value) {
                  if (value != null) {
                    _savedPassword = value;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาป้อนรหัสผ่านของคุณ';
                  }
                  if (value.length < 6) {
                    return 'รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร';
                  }
                  return null;
                },
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'รหัสผ่าน',
                  hintText: 'ป้อนรหัสผ่านของคุณ',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}