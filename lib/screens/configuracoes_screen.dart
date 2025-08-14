import 'package:flutter/material.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  final Color primaryColor = const Color(0xFFDC143C);
  
  bool _notificacoesEventos = true;
  bool _notificacoesLembretes = true;
  bool _notificacoesSistema = false;
  bool _perfilPublico = true;
  bool _compartilharDados = false;
  String _idiomaSelecionado = 'Português';
  final String _armazenamentoUsado = '2.3 MB';

  void _mostrarDialogIdioma() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('Português'),
              value: 'Português',
              groupValue: _idiomaSelecionado,
              onChanged: (value) {
                setState(() {
                  _idiomaSelecionado = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _idiomaSelecionado,
              onChanged: (value) {
                setState(() {
                  _idiomaSelecionado = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Español'),
              value: 'Español',
              groupValue: _idiomaSelecionado,
              onChanged: (value) {
                setState(() {
                  _idiomaSelecionado = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _limparCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Cache'),
        content: const Text('Isso irá limpar dados temporários e pode melhorar o desempenho. Continuar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cache limpo com sucesso!')),
              );
            },
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }

  void _exportarDados() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exportar Dados'),
        content: const Text('Seus dados pessoais serão enviados por email em formato PDF.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dados exportados! Verifique seu email.')),
              );
            },
            child: const Text('Exportar'),
          ),
        ],
      ),
    );
  }

  void _excluirConta() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Conta'),
        content: const Text('⚠️ Esta ação é irreversível! Todos os seus dados serão permanentemente removidos.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conta excluída com sucesso!')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String emoji) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        value: value,
        onChanged: onChanged,
        activeColor: primaryColor,
      ),
    );
  }

  Widget _buildListTile(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(title),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[600])),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('⚙️', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('Configurações'),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSectionHeader('Notificações', '🔔'),
          _buildSwitchTile(
            'Eventos',
            'Receber notificações sobre novos eventos',
            _notificacoesEventos,
            (value) => setState(() => _notificacoesEventos = value),
          ),
          _buildSwitchTile(
            'Lembretes',
            'Lembretes de eventos que você se inscreveu',
            _notificacoesLembretes,
            (value) => setState(() => _notificacoesLembretes = value),
          ),
          _buildSwitchTile(
            'Sistema',
            'Atualizações e informações do sistema',
            _notificacoesSistema,
            (value) => setState(() => _notificacoesSistema = value),
          ),

          _buildSectionHeader('Privacidade', '🔒'),
          _buildSwitchTile(
            'Perfil Público',
            'Permitir que outros usuários vejam seu perfil',
            _perfilPublico,
            (value) => setState(() => _perfilPublico = value),
          ),
          _buildSwitchTile(
            'Compartilhar Dados',
            'Compartilhar dados anônimos para melhorias',
            _compartilharDados,
            (value) => setState(() => _compartilharDados = value),
          ),

          _buildSectionHeader('Preferências', '🎨'),
          _buildListTile(
            'Idioma',
            _idiomaSelecionado,
            Icons.language,
            _mostrarDialogIdioma,
          ),

          _buildSectionHeader('Dados Pessoais', '👤'),
          _buildListTile(
            'Exportar Dados',
            'Baixar uma cópia dos seus dados',
            Icons.download,
            _exportarDados,
          ),
          _buildListTile(
            'Excluir Conta',
            'Remover permanentemente sua conta',
            Icons.delete_forever,
            _excluirConta,
          ),

          _buildSectionHeader('Armazenamento', '💾'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.storage, color: primaryColor),
              title: const Text('Dados do App'),
              subtitle: Text('Usado: $_armazenamentoUsado', style: TextStyle(color: Colors.grey[600])),
              trailing: TextButton(
                onPressed: _limparCache,
                child: const Text('Limpar Cache'),
              ),
            ),
          ),

          _buildSectionHeader('Permissões', '🛡️'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.camera_alt, color: primaryColor),
              title: const Text('Câmera'),
              subtitle: Text('Permitir acesso à câmera', style: TextStyle(color: Colors.grey[600])),
              trailing: const Text('Permitido', style: TextStyle(color: Colors.green)),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.notifications, color: primaryColor),
              title: const Text('Notificações'),
              subtitle: Text('Permitir notificações push', style: TextStyle(color: Colors.grey[600])),
              trailing: const Text('Permitido', style: TextStyle(color: Colors.green)),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.location_on, color: primaryColor),
              title: const Text('Localização'),
              subtitle: Text('Acesso à localização para eventos', style: TextStyle(color: Colors.grey[600])),
              trailing: const Text('Negado', style: TextStyle(color: Colors.red)),
            ),
          ),

          _buildSectionHeader('Sobre', 'ℹ️'),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.info, color: primaryColor),
              title: const Text('Versão do App'),
              subtitle: Text('v1.0.0 (Build 1)', style: TextStyle(color: Colors.grey[600])),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.policy, color: primaryColor),
              title: const Text('Política de Privacidade'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, '/politica-privacidade'),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: ListTile(
              leading: Icon(Icons.description, color: primaryColor),
              title: const Text('Termos de Uso'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () => Navigator.pushNamed(context, '/termos-uso'),
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}