import 'package:flutter/material.dart';

class MeusEventosScreen extends StatefulWidget {
  const MeusEventosScreen({super.key});

  @override
  State<MeusEventosScreen> createState() => _MeusEventosScreenState();
}

class _MeusEventosScreenState extends State<MeusEventosScreen> with SingleTickerProviderStateMixin {
  final Color primaryColor = const Color(0xFFDC143C);
  late TabController _tabController;

  List<Map<String, dynamic>> eventosConfirmados = [
    {
      'id': 1,
      'nome': 'Bazar de Natal',
      'data': '2025-12-10',
      'local': 'Centro Comunitário',
      'periodo': 'Manhã',
      'preco': 10.00,
      'status': 'Confirmado',
      'dataInscricao': '2025-01-15',
    },
    {
      'id': 2,
      'nome': 'Almoço Comunitário',
      'data': '2025-09-01',
      'local': 'Parque Central',
      'periodo': 'Tarde',
      'preco': 15.00,
      'status': 'Confirmado',
      'dataInscricao': '2025-01-10',
    },
  ];

  List<Map<String, dynamic>> eventosPassados = [
    {
      'id': 3,
      'nome': 'Show Beneficente 2024',
      'data': '2024-12-15',
      'local': 'Teatro Municipal',
      'periodo': 'Noite',
      'preco': 25.00,
      'status': 'Participou',
      'avaliacao': 5,
    },
    {
      'id': 4,
      'nome': 'Bazar Solidário',
      'data': '2024-11-20',
      'local': 'Centro Comunitário',
      'periodo': 'Manhã',
      'preco': 8.00,
      'status': 'Participou',
      'avaliacao': 4,
    },
  ];

  List<Map<String, dynamic>> eventosCancelados = [
    {
      'id': 5,
      'nome': 'Workshop de Artesanato',
      'data': '2025-02-20',
      'local': 'Sala de Eventos',
      'periodo': 'Tarde',
      'preco': 20.00,
      'status': 'Cancelado',
      'dataCancelamento': '2025-01-18',
      'motivo': 'Cancelado pelo usuário',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _cancelarEvento(int eventoId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Presença'),
        content: const Text('Tem certeza que deseja cancelar sua presença neste evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                final evento = eventosConfirmados.firstWhere((e) => e['id'] == eventoId);
                evento['status'] = 'Cancelado';
                evento['dataCancelamento'] = DateTime.now().toString().split(' ')[0];
                evento['motivo'] = 'Cancelado pelo usuário';
                eventosCancelados.add(evento);
                eventosConfirmados.removeWhere((e) => e['id'] == eventoId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Presença cancelada com sucesso!')),
              );
            },
            child: const Text('Sim', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _avaliarEvento(Map<String, dynamic> evento) {
    int avaliacao = evento['avaliacao'] ?? 0;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Avaliar: ${evento['nome']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Como foi sua experiência?'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      avaliacao = index + 1;
                    });
                  },
                  icon: Icon(
                    index < avaliacao ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 32,
                  ),
                );
              }),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                evento['avaliacao'] = avaliacao;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Avaliação salva!')),
              );
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(Map<String, dynamic> evento, String tipo) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    evento['nome'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(evento['status']),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    evento['status'],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('${evento['data']} - ${evento['periodo']}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(evento['local']),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.attach_money, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text('R\$ ${evento['preco'].toStringAsFixed(2)}'),
              ],
            ),
            if (evento['dataInscricao'] != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.how_to_reg, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text('Inscrito em: ${evento['dataInscricao']}'),
                ],
              ),
            ],
            if (evento['dataCancelamento'] != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.cancel, size: 16, color: Colors.red),
                  const SizedBox(width: 4),
                  Text('Cancelado em: ${evento['dataCancelamento']}'),
                ],
              ),
            ],
            if (evento['avaliacao'] != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Sua avaliação: '),
                  ...List.generate(5, (index) {
                    return Icon(
                      index < evento['avaliacao'] ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (tipo == 'confirmados') ...[
                  TextButton.icon(
                    onPressed: () => _cancelarEvento(evento['id']),
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    label: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                  ),
                ],
                if (tipo == 'passados') ...[
                  TextButton.icon(
                    onPressed: () => _avaliarEvento(evento),
                    icon: const Icon(Icons.star, color: Colors.amber),
                    label: const Text('Avaliar'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmado':
        return Colors.green;
      case 'Participou':
        return Colors.blue;
      case 'Cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildTabContent(String tipo) {
    List<Map<String, dynamic>> eventos;
    String emptyMessage;
    String emptyIcon;

    switch (tipo) {
      case 'confirmados':
        eventos = eventosConfirmados;
        emptyMessage = 'Nenhum evento confirmado';
        emptyIcon = '📅';
        break;
      case 'passados':
        eventos = eventosPassados;
        emptyMessage = 'Nenhuma avaliação';
        emptyIcon = '⭐';
        break;
      case 'cancelados':
        eventos = eventosCancelados;
        emptyMessage = 'Nenhum evento cancelado';
        emptyIcon = '❌';
        break;
      default:
        eventos = [];
        emptyMessage = '';
        emptyIcon = '';
    }

    if (eventos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emptyIcon, style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        return _buildEventCard(eventos[index], tipo);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📅', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('Meus Eventos'),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'Confirmados'),
            Tab(text: 'Avaliações'),
            Tab(text: 'Cancelados'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent('confirmados'),
          _buildTabContent('passados'),
          _buildTabContent('cancelados'),
        ],
      ),
    );
  }
}