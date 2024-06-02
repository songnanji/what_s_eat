import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _autoLogin = false;

  @override
  void initState() {
    super.initState();
    _loadAutoLoginInfo();
  }

  void _loadAutoLoginInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool autoLogin = prefs.getBool('autoLogin') ?? false;
    if (autoLogin) {
      String? id = prefs.getString('id');
      String? password = prefs.getString('password');
      if (id != null && password != null) {
        setState(() {
          _idController.text = id;
          _passwordController.text = password;
          _autoLogin = true;
        });
      }
    }
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedId = prefs.getString('id');
    String? storedPassword = prefs.getString('password');

    if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
      _showErrorDialog('아이디/비밀번호가 입력되지 않았습니다');
      return;
    }

    if (storedId == _idController.text && storedPassword == _passwordController.text) {
      if (_autoLogin) {
        prefs.setBool('autoLogin', true);
        prefs.setString('id', _idController.text);
        prefs.setString('password', _passwordController.text);
      } else {
        prefs.setBool('autoLogin', false);
      }
      _showSuccessDialog('로그인에 성공했습니다!');
    } else {
      _showErrorDialog('아이디 또는 비밀번호가 잘못되었습니다.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/home');
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.lock,
              size: 300,
              color: Colors.lightGreen,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'PW'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('자동 로그인'),
                Checkbox(
                  value: _autoLogin,
                  onChanged: (value) {
                    setState(() {
                      _autoLogin = value!;
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Log-in'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.lightGreen),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

