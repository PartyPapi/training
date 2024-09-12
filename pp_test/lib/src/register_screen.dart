import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/auth_service.dart';
import 'profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
              child: const Text('Register'),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  var user = await authService.registerWithEmailAndPassword(
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
          ],
        ),
      ),
    );
  }
}
