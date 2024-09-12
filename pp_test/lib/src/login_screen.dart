import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/auth_service.dart';
import 'register_screen.dart';
import 'profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
              onChanged: (val) => setState(() => _email = val),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              validator: (val) =>
                  val!.length < 6 ? 'Enter a password 6+ chars long' : null,
              onChanged: (val) => setState(() => _password = val),
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var user = await authService.signInWithEmailAndPassword(
                      _email, _password);
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()),
                    );
                  }
                }
              },
            ),
            TextButton(
              child: const Text('Register'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
