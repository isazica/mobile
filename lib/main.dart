import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final primaryColor = Color(0xFFEF5350); // Vermelho suave
  final secondaryColor = Color(0xFFF1F1F1); // Cinza claro

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coração Generoso',
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
        fontFamily: 'Roboto',
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primaryColor, width: 2),
          ),
          labelStyle: TextStyle(color: primaryColor),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.all(primaryColor),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.all(primaryColor),
        ),
      ),
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
  String? _sexo = 'Masculino'; 
  bool _aceitouTermos = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coração Generoso',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: primaryColor,
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
              SizedBox(height: 24),
              Text('Onde você conheceu o projeto?', style: TextStyle(fontWeight: FontWeight.w600)),
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
              SizedBox(height: 24),
              Text('Sexo', style: TextStyle(fontWeight: FontWeight.w600)),
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
                  SizedBox(width: 12),
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
                  SizedBox(width: 12),
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
              SizedBox(height: 24),
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
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
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
                    style: TextStyle(
                      color: Colors.orange[700], // Tom laranja suave
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              SizedBox(height: 32),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      Colors.white,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      primaryColor,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: primaryColor),
                      ),
                    ),
                    padding: WidgetStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                    elevation: WidgetStateProperty.all(
                      0.0,
                    ),
                    textStyle: WidgetStateProperty.all(
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                  child: Text('Cadastrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
