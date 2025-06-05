import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _senha = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              Text('Email', style: TextStyle(fontSize: 18)),
              TextField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => _email = value,
                decoration: InputDecoration(
                  hintText: 'Digite seu email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 24),
              Text('Senha', style: TextStyle(fontSize: 18)),
              TextField(
                obscureText: _obscureText,
                onChanged: (value) => _senha = value,
                decoration: InputDecoration(
                  hintText: 'Digite sua senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() => _obscureText = !_obscureText);
                    },
                  ),
                ),
              ),
              SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  if (_email.isNotEmpty && _senha.isNotEmpty) {
                    // Aqui você pode implementar a lógica de login
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text('Login realizado com sucesso!'),
                        );
                      },
                    );
                  }
                },
                child: Text('Entrar'),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    EdgeInsets.symmetric(vertical: 16),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    Color(0xFF6200EE), // Cor roxa
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(fontSize: 18),
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
