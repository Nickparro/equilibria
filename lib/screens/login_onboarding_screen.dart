import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String? errorMessage;

  void _handleLogin() {
    final user = userController.text.trim();
    final pass = passController.text.trim();

    if (user.isEmpty || pass.isEmpty) {
      setState(() {
        errorMessage = 'Por favor completa todos los campos.';
      });
    } else {
      setState(() {
        errorMessage = null;
      });

      // Navegar al home
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            TextField(
              controller: userController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            if (errorMessage != null) ...[
              SizedBox(height: 20),
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            ],
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
