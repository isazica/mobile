import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:math';

class MeusIngressosScreen extends StatelessWidget {
  const MeusIngressosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFD32F2F);
    
    final List<Map<String, dynamic>> ingressos = [
      {
        'id': 1,
        'evento': 'Show Beneficente 2024',
        'data': '2024-12-15',
        'local': 'Teatro Municipal',
        'periodo': 'Noite',
        'preco': 25.00,
        'codigo': 'CG${Random().nextInt(999999).toString().padLeft(6, '0')}',
        'status': 'Válido',
        'dataCompra': '2024-11-20',
      },
      {
        'id': 2,
        'evento': 'Bazar Solidário',
        'data': '2024-11-20',
        'local': 'Centro Comunitário',
        'periodo': 'Manhã',
        'preco': 8.00,
        'codigo': 'CG${Random().nextInt(999999).toString().padLeft(6, '0')}',
        'status': 'Usado',
        'dataCompra': '2024-11-15',
      },
      {
        'id': 3,
        'evento': 'Almoço de Páscoa',
        'data': '2025-03-31',
        'local': 'Parque Central',
        'periodo': 'Tarde',
        'preco': 15.00,
        'codigo': 'CG${Random().nextInt(999999).toString().padLeft(6, '0')}',
        'status': 'Válido',
        'dataCompra': '2025-01-10',
      },
    ];

    Color getStatusColor(String status) {
      switch (status) {
        case 'Válido':
          return Colors.green;
        case 'Usado':
          return Colors.blue;
        case 'Expirado':
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🎫', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('Meus Ingressos'),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ingressos.isEmpty
          ? Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.white, Color(0xFFFCE4EC)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🎫', style: TextStyle(fontSize: 64)),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum ingresso encontrado',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: ingressos.length,
              itemBuilder: (context, index) {
                final ingresso = ingressos[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Color(0xFFFCE4EC)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ingresso['evento'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: getStatusColor(ingresso['status']),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  ingresso['status'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: QrImageView(
                              data: 'CG-${ingresso['codigo']}-${ingresso['evento']}-${ingresso['data']}',
                              version: QrVersions.auto,
                              size: 80.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text('${ingresso['data']} - ${ingresso['periodo']}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(ingresso['local']),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text('R\$ ${ingresso['preco'].toStringAsFixed(2)}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.confirmation_number, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text('Código: ${ingresso['codigo']}'),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.shopping_cart, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text('Comprado em: ${ingresso['dataCompra']}'),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Ingresso compartilhado!')),
                                  );
                                },
                                icon: const Icon(Icons.share, size: 16),
                                label: const Text('Compartilhar'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Ingresso salvo!')),
                                  );
                                },
                                icon: const Icon(Icons.download, size: 16),
                                label: const Text('Salvar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}