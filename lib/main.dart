import 'package:flutter/material.dart';
import 'login.dart'; // Importa a tela de login

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFFEF5350);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: primaryColor),
      home: CadastroForm(),
    );
  }
}

class CadastroForm extends StatefulWidget {
  @override
  _CadastroFormState createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  String _conhecimentoProjeto = 'Escolha';
  String? _sexo = 'Masculino';
  bool _aceitouTermos = false;
  bool _obscureText = true;

  final Color primaryColor = Color(0xFFEF5350);

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: primaryColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onCadastrar() {
    if (_nomeController.text.isEmpty) {
      _showMessage('Por favor, insira seu nome');
      return;
    }

    String email = _emailController.text;

    if (!email.contains('@') || !email.endsWith('.com')) {
      _showMessage('Por favor, insira um email válido que contenha "@" e termine com ".com"');
      return;
    }

    if (_senhaController.text.isEmpty || _senhaController.text.length < 6) {
      _showMessage('Senha deve ter pelo menos 6 caracteres');
      return;
    }
    if (_conhecimentoProjeto == 'Escolha') {
      _showMessage('Por favor, selecione onde conheceu o projeto');
      return;
    }
    if (!_aceitouTermos) {
      _showMessage('Você deve aceitar os termos e condições');
      return;
    }

    _showMessage('Cadastrado: ${_nomeController.text} (${_emailController.text})');
  }

  void _onLogin() {
    // Navega para a tela de login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coração Generoso'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Nome
                Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Email
                Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Senha
                Text('Senha', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _senhaController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _obscureText = !_obscureText),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(
                            _obscureText ? Icons.visibility_off : Icons.visibility,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Conheceu o projeto
                Text('Onde você conheceu o projeto?', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _conhecimentoProjeto,
                    underline: SizedBox(),
                    items: [
                      'Escolha',
                      'Redes sociais',
                      'Amigos',
                      'Publicidade',
                      'Outro'
                    ].map((e) => DropdownMenuItem(child: Text(e), value: e)).toList(),
                    onChanged: (v) => setState(() => _conhecimentoProjeto = v ?? 'Escolha'),
                  ),
                ),
                SizedBox(height: 24),

                // Sexo
                Text('Sexo', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Masculino',
                      groupValue: _sexo,
                      onChanged: (v) => setState(() => _sexo = v),
                    ),
                    Text('Masculino'),
                    SizedBox(width: 12),
                    Radio<String>(
                      value: 'Feminino',
                      groupValue: _sexo,
                      onChanged: (v) => setState(() => _sexo = v),
                    ),
                    Text('Feminino'),
                    SizedBox(width: 12),
                    Radio<String>(
                      value: 'Outro',
                      groupValue: _sexo,
                      onChanged: (v) => setState(() => _sexo = v),
                    ),
                    Text('Outro'),
                  ],
                ),
                SizedBox(height: 24),

                // Termos
                Row(
                  children: [
                    Checkbox(
                      value: _aceitouTermos,
                      onChanged: (v) => setState(() => _aceitouTermos = v ?? false),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _aceitouTermos = !_aceitouTermos),
                        child: Text(
                          'Aceito os Termos e Condições',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),

                // Botão Cadastrar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _onCadastrar,
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Botão Login
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: _onLogin, // Navega para LoginScreen
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
