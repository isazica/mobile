import 'package:flutter/material.dart';
class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de eventos (substituir depois pela chamada à API/BD)
    final List<Map<String, String>> eventos = [
      {
        'nome': 'Bazar Solidário',
        'data': '20/06/2025',
        'descricao': 'Venda de roupas e calçados para arrecadar fundos.',
      },
      {
        'nome': 'Almoço Comunitário',
        'data': '25/06/2025',
        'descricao': 'Almoço aberto à comunidade com música ao vivo.',
      },
      {
        'nome': 'Show Beneficente',
        'data': '30/06/2025',
        'descricao': 'Apresentações artísticas com renda revertida para a ONG.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Eventos do Coração generoso"),
        backgroundColor: const Color.fromARGB(255, 211, 78, 78),
      ),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(
                evento['nome']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('📅 ${evento['data']}'),
                  const SizedBox(height: 4),
                  Text(evento['descricao']!),
                ],
              ),
              onTap: () {
                // Aqui pode colocar navegação para detalhes futuramente
              },
            ),
          );
        },
      ),
    );
  }
}
