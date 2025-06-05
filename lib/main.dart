import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'login.dart';
import 'feedback.dart';
import 'cadastroDoacao.dart';
import 'perfil.dart';
import 'categoria.dart';
import 'suporte.dart';
import 'sobre.dart';
import 'telaInicial.dart';
import 'doacaoDinheiro.dart';
import 'trocaSenha.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CadastroForm(),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _email = '';
  String _senha = '';
  String _conhecimentoProjeto = 'Escolha';
  String? _sexo = 'Masculino'; // Valor inicial (Masculino)
  bool _aceitouTermos = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Usuário')),
      body: Container(
        color: Color(0xFFFFEBF0),
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu nome';
                  }
                  return null;
                },
                onSaved: (value) => _nome = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  if (!value.contains('@')) {
                    return 'Email inválido. O símbolo "@" é obrigatório';
                  }
                  return null;
                },
                onSaved: (value) => _email = value ?? '',
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                obscureText: _obscureText,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
                onSaved: (value) => _senha = value ?? '',
              ),
              SizedBox(height: 20),
              
              // Adição do campo de "Onde você conheceu o projeto?"
              Text('Onde você conheceu o projeto?'),
              DropdownButtonFormField<String>(
                value: _conhecimentoProjeto,
                items: <String>['Escolha', 'Redes sociais', 'Amigos', 'Publicidade', 'Outro']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _conhecimentoProjeto = newValue!;
                  });
                },
                validator: (value) {
                  if (value == 'Escolha') {
                    return 'Por favor, selecione uma opção';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              
              // Adição do campo "Sexo"
              Text('Sexo'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Masculino',
                    groupValue: _sexo,
                    onChanged: (value) {
                      setState(() {
                        _sexo = value;
                      });
                    },
                  ),
                  Text('Masculino'),
                  Radio<String>(
                    value: 'Feminino',
                    groupValue: _sexo,
                    onChanged: (value) {
                      setState(() {
                        _sexo = value;
                      });
                    },
                  ),
                  Text('Feminino'),
                  Radio<String>(
                    value: 'Outro',
                    groupValue: _sexo,
                    onChanged: (value) {
                      setState(() {
                        _sexo = value;
                      });
                    },
                  ),
                  Text('Outro'),
                ],
              ),
              SizedBox(height: 20),

              // Adição do campo de "Aceitar Termos"
              Row(
                children: [
                  Checkbox(
                    value: _aceitouTermos,
                    onChanged: (bool? value) {
                      setState(() {
                        _aceitouTermos = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _aceitouTermos = !_aceitouTermos;
                        });
                      },
                      child: Text(
                        'Aceito os Termos e Condições',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (!_aceitouTermos)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Você precisa aceitar os termos e condições para continuar.',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Cadastrar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (!_aceitouTermos) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Você deve aceitar os termos e condições')),
                      );
                      return;
                    }
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cadastrado: $_nome ($_email)')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
