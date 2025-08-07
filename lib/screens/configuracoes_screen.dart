import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final Color primaryColor = const Color(0xFFD32F2F);
  final Color secondaryColor = const Color(0xFF616161);
  final Color accentColor = const Color(0xFFF8BBD9);
  
  bool notificacoesAtivas = true;
  bool cameraPermitida = true;
  bool notificacoesBloqueadas = false;
  String idiomaAtual = 'Português';

  final List<Map<String, dynamic>> presencasEventos = [
    {'nome': 'Bazar de Natal', 'data': '10/12/2024', 'presente': true},
    {'nome': 'Show de Rock', 'data': '15/08/2024', 'presente': false},
    {'nome': 'Almoço Comunitário', 'data': '01/09/2024', 'presente': true},
  ];

  void _convidarAmigos() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Convidar Amigos'),
        content: const Text('Compartilhe o link do app:\nhttps://coracaogeneroso.app'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Compartilhar'),
          ),
        ],
      ),
    );
  }

  void _verPrivacidade() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacidade'),
        content: const Text('Suas informações são protegidas conforme nossa política de privacidade.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _verPresencas() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Presenças nos Eventos'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: presencasEventos.length,
            itemBuilder: (context, index) {
              final evento = presencasEventos[index];
              return ListTile(
                title: Text(evento['nome']),
                subtitle: Text(evento['data']),
                trailing: Icon(
                  evento['presente'] ? Icons.check_circle : Icons.cancel,
                  color: evento['presente'] ? Colors.green : Colors.red,
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _alterarIdioma() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Idioma do App'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Português'),
              value: 'Português',
              groupValue: idiomaAtual,
              onChanged: (value) {
                setState(() {
                  idiomaAtual = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: idiomaAtual,
              onChanged: (value) {
                setState(() {
                  idiomaAtual = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'Español',
              groupValue: idiomaAtual,
              onChanged: (value) {
                setState(() {
                  idiomaAtual = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Geral', [
            _buildSwitchTile(
              icon: Icons.notifications,
              title: 'Notificações',
              subtitle: 'Receber notificações do app',
              value: notificacoesAtivas,
              onChanged: (value) {
                setState(() {
                  notificacoesAtivas = value;
                });
              },
            ),
            _buildTile(
              icon: Icons.person_add,
              title: 'Convidar Amigos',
              subtitle: 'Compartilhe o app com seus amigos',
              onTap: _convidarAmigos,
            ),
            _buildTile(
              icon: Icons.privacy_tip,
              title: 'Privacidade',
              subtitle: 'Política de privacidade',
              onTap: _verPrivacidade,
            ),
            _buildTile(
              icon: Icons.event_available,
              title: 'Presenças nos Eventos',
              subtitle: 'Histórico de participação',
              onTap: _verPresencas,
            ),
            _buildTile(
              icon: Icons.language,
              title: 'Idioma do App',
              subtitle: idiomaAtual,
              onTap: _alterarIdioma,
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection('Permissões', [
            _buildSwitchTile(
              icon: Icons.camera_alt,
              title: 'Câmera',
              subtitle: 'Permitir acesso à câmera',
              value: cameraPermitida,
              onChanged: (value) {
                setState(() {
                  cameraPermitida = value;
                });
              },
            ),
            _buildSwitchTile(
              icon: Icons.notifications_off,
              title: 'Bloquear Notificações',
              subtitle: 'Bloquear todas as notificações',
              value: notificacoesBloqueadas,
              onChanged: (value) {
                setState(() {
                  notificacoesBloqueadas = value;
                });
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      activeColor: primaryColor,
      onChanged: onChanged,
    );
  }
}