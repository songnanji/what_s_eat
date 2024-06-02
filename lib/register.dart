import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _register() async {
    if (_idController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty) {
      _showDialog('모든 필드를 채워주세요.');
      return;
    }

    if (_passwordController.text.length < 8) {
      _showDialog('비밀번호는 8자리 이상으로 입력해주세요.');
      return;
    }

    if (!_passwordController.text.contains(RegExp(r'[0-9]')) ||
        !_passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      _showDialog('숫자와 특수문자 2가지를 사용해서 입력해주세요.');
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', _idController.text);
    prefs.setString('password', _passwordController.text);
    prefs.setString('name', _nameController.text);
    prefs.setString('email', _emailController.text);
    prefs.setString('phone', _phoneController.text);

    _showDialog('회원가입에 성공했습니다!', success: true);
  }

  void _showDialog(String message, {bool success = false}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (success) {
                Navigator.pop(context);
              }
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'PW'),
              obscureText: true,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: '성명'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: '전화번호'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('회원가입'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
            ),
          ],
        ),
      ),
    );
  }
}

