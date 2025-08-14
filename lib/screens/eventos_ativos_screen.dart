import 'package:flutter/material.dart';
import 'detalhes_evento_screen.dart';
import 'pagamento_screen.dart';
import 'ingresso_screen.dart';

class EventosAtivosScreen extends StatefulWidget {
  const EventosAtivosScreen({super.key});

  @override
  State<EventosAtivosScreen> createState() => _EventosAtivosScreenState();
}

class _EventosAtivosScreenState extends State<EventosAtivosScreen> {
  final Color primaryColor = const Color(0xFFDC143C);
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> eventosAtivos = [
    {
      'id': 1,
      'nome': 'Bazar de Natal',
      'descricao': 'Bazar beneficente com roupas e brinquedos para toda família',
      'localEvento': 'Centro Comunitário',
      'dataEvento': '2025-12-10',
      'periodo': 'Manhã',
      'preco': 10.00,
      'categoria': 'Bazar',
      'vagas': 50,
    },
    {
      'id': 2,
      'nome': 'Show de Rock',
      'descricao': 'Show de rock com bandas locais para arrecadar fundos',
      'localEvento': 'Arena Municipal',
      'dataEvento': '2025-08-15',
      'periodo': 'Noite',
      'preco': 50.00,
      'categoria': 'Show',
      'vagas': 200,
    },
    {
      'id': 3,
      'nome': 'Almoço Comunitário',
      'descricao': 'Almoço solidário para a comunidade local',
      'localEvento': 'Parque Central',
      'dataEvento': '2025-09-01',
      'periodo': 'Tarde',
      'preco': 15.00,
      'categoria': 'Almoço',
      'vagas': 100,
    },
    {
      'id': 4,
      'nome': 'Workshop de Arte',
      'descricao': 'Oficina de arte para crianças e adolescentes',
      'localEvento': 'Escola Municipal',
      'dataEvento': '2025-07-20',
      'periodo': 'Manhã',
      'preco': 5.00,
      'categoria': 'Workshop',
      'vagas': 30,
    },
    {
      'id': 5,
      'nome': 'Feira de Adoção',
      'descricao': 'Feira de adoção de animais abandonados',
      'localEvento': 'Praça da Cidade',
      'dataEvento': '2025-06-15',
      'periodo': 'Tarde',
      'preco': 0.00,
      'categoria': 'Feira',
      'vagas': 0,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get filteredEventos {
    if (_searchQuery.isEmpty) {
      return eventosAtivos;
    }
    return eventosAtivos.where((e) =>
        e['nome'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        e['descricao'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        e['localEvento'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        e['categoria'].toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  IconData getEventIcon(String nome) {
    if (nome.toLowerCase().contains('bazar')) return Icons.shopping_bag;
    if (nome.toLowerCase().contains('show') || nome.toLowerCase().contains('rock')) return Icons.music_note;
    if (nome.toLowerCase().contains('almoço') || nome.toLowerCase().contains('comida')) return Icons.restaurant;
    if (nome.toLowerCase().contains('workshop') || nome.toLowerCase().contains('arte')) return Icons.palette;
    if (nome.toLowerCase().contains('feira') || nome.toLowerCase().contains('adoção')) return Icons.pets;
    return Icons.event;
  }

  void _participarEvento(Map<String, dynamic> evento) {
    if (evento['preco'] == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IngressoScreen(evento: evento, metodoPagamento: 'gratuito'),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PagamentoScreen(evento: evento),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🎯', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('Eventos Ativos'),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar eventos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredEventos.isEmpty
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
                          const Text('🔍', style: TextStyle(fontSize: 64)),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhum evento encontrado para "$_searchQuery"',
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredEventos.length,
                    itemBuilder: (context, index) {
                      final evento = filteredEventos[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        elevation: 6,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesEventoScreen(evento: evento),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(18),
                          child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFFCE4EC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        getEventIcon(evento['nome']),
                                        color: Colors.white,
                                        size: 30,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            evento['nome'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: primaryColor.withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              evento['categoria'],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  evento['descricao'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 18, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        evento['localEvento'],
                                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${evento['dataEvento']} • ${evento['periodo']}',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                if (evento['vagas'] > 0) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.people, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${evento['vagas']} vagas disponíveis',
                                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ],
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        evento['preco'] == 0 
                                            ? 'GRATUITO' 
                                            : 'R\$ ${evento['preco'].toStringAsFixed(2)}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () => _participarEvento(evento),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      ),
                                      child: const Text('Participar'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}