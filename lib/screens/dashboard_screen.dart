import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final Color primaryColor = const Color(0xFFEF5350);

  final List<Map<String, dynamic>> usuarios = [
    {
      'id': 1,
      'nome': 'Fulano da Silva',
      'email': 'fulano@email.com.br',
      'nivelAcesso': 'ADMIN',
      'statusUsuario': 'ATIVO',
      'avatar':
          'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'id': 2,
      'nome': 'Beltrana de Sá',
      'email': 'beltrana@email.com.br',
      'nivelAcesso': 'USER',
      'statusUsuario': 'ATIVO',
      'avatar': 'https://randomuser.me/api/portraits/women/44.jpg',
    },
    {
      'id': 3,
      'nome': 'Sicrana de Oliveira',
      'email': 'sicrana@email.com.br',
      'nivelAcesso': 'USER',
      'statusUsuario': 'INATIVO',
      'avatar': 'https://randomuser.me/api/portraits/women/68.jpg',
    },
  ];

  final List<Map<String, dynamic>> categorias = [
    {'id': 1, 'nome': 'Bazar'},
    {'id': 2, 'nome': 'Almoço'},
    {'id': 3, 'nome': 'Show'},
  ];

  final List<Map<String, dynamic>> eventos = [
    {
      'id': 1,
      'nome': 'Bazar de Natal',
      'descricao': 'Bazar beneficente com roupas e brinquedos',
      'localEvento': 'Centro Comunitário',
      'dataEvento': '2025-12-10',
      'periodo': 'Manhã',
      'preco': 10.00,
      'categoria_id': 1,
      'statusEvento': 'ATIVO',
      'imagem':
          'https://images.unsplash.com/photo-1513708922913-5f36b1fbd7e4?auto=format&fit=crop&w=800&q=60',
    },
    {
      'id': 2,
      'nome': 'Show de Rock',
      'descricao': 'Show de rock com bandas locais',
      'localEvento': 'Arena Municipal',
      'dataEvento': '2025-08-15',
      'periodo': 'Noite',
      'preco': 50.00,
      'categoria_id': 3,
      'statusEvento': 'ATIVO',
      'imagem':
          'https://images.unsplash.com/photo-1508609349937-5ec4ae374ebf?auto=format&fit=crop&w=800&q=60',
    },
    {
      'id': 3,
      'nome': 'Almoço Comunitário',
      'descricao': 'Almoço para a comunidade',
      'localEvento': 'Parque Central',
      'dataEvento': '2025-09-01',
      'periodo': 'Tarde',
      'preco': 15.00,
      'categoria_id': 2,
      'statusEvento': 'ATIVO',
      'imagem':
          'https://images.unsplash.com/photo-1551218808-94e220e084d2?auto=format&fit=crop&w=800&q=60',
    },
  ];

  List<Map<String, dynamic>> suporteMensagens = [
    {
      'id': 1,
      'emissor': 'Suporte',
      'texto': 'Olá! Como podemos ajudar você hoje?',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  int? categoriaSelecionadaId;

  final List<String> tabs = [
    'Usuários',
    'Categorias',
    'Eventos',
    'Suporte',
    'Presenças'
  ];

  late TextEditingController _mensagemController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _mensagemController = TextEditingController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mensagemController.dispose();
    super.dispose();
  }

  void _navigateToTab(int index) {
    Navigator.pop(context);
    setState(() {
      _tabController.index = index;
    });
  }

  Widget _buildUsuariosTab() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: usuarios.length,
      itemBuilder: (context, i) {
        final u = usuarios[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(u['avatar']),
              backgroundColor: Colors.grey[300],
            ),
            title: Text(u['nome'],
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('${u['email']} • ${u['nivelAcesso']}'),
            trailing: Icon(
              u['statusUsuario'] == 'ATIVO' ? Icons.check_circle : Icons.cancel,
              color: u['statusUsuario'] == 'ATIVO' ? Colors.green : Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoriasTab() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 14,
        runSpacing: 12,
        children: categorias.map((cat) {
          final isSelected = categoriaSelecionadaId == cat['id'];
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? primaryColor : Colors.grey[300],
              foregroundColor: isSelected ? Colors.white : Colors.black87,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              setState(() {
                categoriaSelecionadaId = cat['id'];
                _tabController.index = tabs.indexOf('Eventos');
              });
            },
            child: Text(cat['nome'], style: const TextStyle(fontSize: 18)),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEventosTab() {
    final filtered = eventos
        .where((e) =>
            e['statusEvento'] == 'ATIVO' &&
            (categoriaSelecionadaId == null ||
                e['categoria_id'] == categoriaSelecionadaId))
        .toList();

    if (categoriaSelecionadaId != null && filtered.isEmpty) {
      return Center(
          child: Text('Nenhum evento ativo nesta categoria',
              style: TextStyle(fontSize: 18, color: Colors.grey[700])));
    }
    if (categoriaSelecionadaId == null) {
      return Center(
          child: Text('Selecione uma categoria',
              style: TextStyle(fontSize: 18, color: Colors.grey[700])));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      itemCount: filtered.length,
      itemBuilder: (context, i) {
        final e = filtered[i];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          clipBehavior: Clip.antiAlias,
          elevation: 6,
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  e['imagem'],
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[300],
                    child:
                        const Center(child: Icon(Icons.broken_image, size: 60)),
                  ),
                ),
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['nome'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            )
                          ]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${e['descricao']}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Local: ${e['localEvento']}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Data: ${e['dataEvento']} - ${e['periodo']}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Preço: R\$${e['preco'].toStringAsFixed(2)}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSuporteTab() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: suporteMensagens.length,
            itemBuilder: (context, i) {
              final msg = suporteMensagens[i];
              bool isUser = msg['emissor'] != 'Suporte';
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: isUser ? primaryColor : Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    msg['texto'],
                    style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _mensagemController,
                  decoration: InputDecoration(
                    hintText: 'Digite sua mensagem',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  String texto = _mensagemController.text.trim();
                  if (texto.isEmpty) return;

                  setState(() {
                    suporteMensagens.add({
                      'id': suporteMensagens.length + 1,
                      'emissor': 'Usuário',
                      'texto': texto,
                      'timestamp': DateTime.now(),
                    });
                    _mensagemController.clear();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Icon(Icons.send),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPresencasTab() {
    return const Center(
      child: Text('Presenças - Em construção'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: primaryColor,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e)).toList(),
          indicatorColor: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFEF5350)),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Usuários'),
              onTap: () => _navigateToTab(tabs.indexOf('Usuários')),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categorias'),
              onTap: () => _navigateToTab(tabs.indexOf('Categorias')),
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text('Eventos'),
              onTap: () => _navigateToTab(tabs.indexOf('Eventos')),
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Suporte'),
              onTap: () => _navigateToTab(tabs.indexOf('Suporte')),
            ),
            ListTile(
              leading: const Icon(Icons.check_circle),
              title: const Text('Presenças'),
              onTap: () => _navigateToTab(tabs.indexOf('Presenças')),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUsuariosTab(),
          _buildCategoriasTab(),
          _buildEventosTab(),
          _buildSuporteTab(),
          _buildPresencasTab(),
        ],
      ),
    );
  }
}
