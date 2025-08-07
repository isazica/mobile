import 'package:flutter/material.dart';

class SuporteScreen extends StatefulWidget {
  const SuporteScreen({super.key});

  @override
  State<SuporteScreen> createState() => _SuporteScreenState();
}

class _SuporteScreenState extends State<SuporteScreen> {
  final Color primaryColor = const Color(0xFFEF5350);
  final List<Map<String, dynamic>> suporteMensagens = [
    {
      'id': 1,
      'emissor': 'Suporte',
      'texto': 'Olá! Como podemos ajudar você hoje?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  late TextEditingController _mensagemController;

  @override
  void initState() {
    super.initState();
    _mensagemController = TextEditingController();
  }

  @override
  void dispose() {
    _mensagemController.dispose();
    super.dispose();
  }

  void _enviarMensagem() {
    final txt = _mensagemController.text.trim();
    if (txt.isEmpty) return;
    setState(() {
      suporteMensagens.add({
        'id': suporteMensagens.length + 1,
        'emissor': 'Usuário',
        'texto': txt,
        'timestamp': DateTime.now(),
      });
      _mensagemController.clear();

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          suporteMensagens.add({
            'id': suporteMensagens.length + 1,
            'emissor': 'Suporte',
            'texto':
                'Recebemos sua mensagem: "$txt". Em breve responderemos!',
            'timestamp': DateTime.now(),
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(12),
            itemCount: suporteMensagens.length,
            itemBuilder: (context, idx) {
              final msg = suporteMensagens[suporteMensagens.length - 1 - idx];
              final isUser = msg['emissor'] == 'Usuário';
              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7),
                  decoration: BoxDecoration(
                    color: isUser ? primaryColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    msg['texto'],
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _mensagemController,
                  decoration:
                      const InputDecoration(hintText: 'Digite sua mensagem...'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, color: primaryColor),
                onPressed: _enviarMensagem,
              )
            ],
          ),
        )
      ],
    );
  }
}
