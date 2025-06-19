import 'package:flutter/material.dart';

class TelaDetalhesEvento extends StatelessWidget {
  final Map<String, dynamic> evento;

  const TelaDetalhesEvento({super.key, required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(evento['nome']),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              evento['nome'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text('📅 Data: ${evento['data']}'),
            Text('📍 Local: ${evento['local']}'),
            Text('🎫 Preço: R\$ ${evento['preco'].toStringAsFixed(2)}'),
            Text('🏷️ Categoria: ${evento['categoria']}'),
            const SizedBox(height: 16),
            Text(
              evento['descricao'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
