import 'package:flutter/material.dart';


class PerfilScreen extends StatelessWidget {
  final String nome;
  final String email;
  final String avatarUrl;
  final String nivelAcesso;
  final String statusUsuario;

  const PerfilScreen({
    Key? key,
    required this.nome,
    required this.email,
    required this.avatarUrl,
    required this.nivelAcesso,
    required this.statusUsuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de $nome'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(avatarUrl),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(nome,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(email, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Chip(
                  label: Text(nivelAcesso),
                  backgroundColor: nivelAcesso == 'ADMIN'
                      ? Colors.red.shade300
                      : Colors.blue.shade300,
                ),
                const SizedBox(width: 12),
                Chip(
                  label: Text(statusUsuario),
                  backgroundColor: statusUsuario == 'ATIVO'
                      ? Colors.green.shade300
                      : Colors.grey.shade400,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
