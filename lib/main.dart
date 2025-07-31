import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFEF5350);
    return MaterialApp(
      title: 'Gestão de Eventos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
            .copyWith(secondary: primaryColor),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

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
      'statusUsuario': 'ATIVO'
    },
    {
      'id': 2,
      'nome': 'Beltrana de Sá',
      'email': 'beltrana@email.com.br',
      'nivelAcesso': 'USER',
      'statusUsuario': 'ATIVO'
    },
    {
      'id': 3,
      'nome': 'Sicrana de Oliveira',
      'email': 'sicrana@email.com.br',
      'nivelAcesso': 'USER',
      'statusUsuario': 'INATIVO'
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
      'localEnvento': 'Centro Comunitário',
      'cep': '12345678',
      'numero': '123',
      'complemento': 'Sala 1',
      'dataEvento': '2025-12-10',
      'periodo': 'Manhã',
      'preco': 10.00,
      'categoria_id': 1,
      'statusEvento': 'ATIVO'
    },
    {
      'id': 2,
      'nome': 'Show de Rock',
      'descricao': 'Show de rock com bandas locais',
      'localEnvento': 'Arena Municipal',
      'cep': '87654321',
      'numero': '456',
      'complemento': '',
      'dataEvento': '2025-08-15',
      'periodo': 'Noite',
      'preco': 50.00,
      'categoria_id': 3,
      'statusEvento': 'CANCELADO'
    },
  ];

  final List<Map<String, dynamic>> mensagens = [
    {
      'id': 1,
      'emissor': 'Fulano',
      'email': 'fulano@email.com',
      'texto': 'Gostaria de mais informações.',
      'statusMensagem': 'ATIVO'
    },
    {
      'id': 2,
      'emissor': 'Beltrana',
      'email': 'beltrana@email.com',
      'texto': 'O evento do bazar foi cancelado?',
      'statusMensagem': 'ATIVO'
    },
  ];

  final List<Map<String, dynamic>> presencas = [
    {'id': 1, 'evento_id': 1, 'usuario_id': 1, 'statusPresenca': 'CONFIRMADO'},
    {'id': 2, 'evento_id': 2, 'usuario_id': 2, 'statusPresenca': 'CANCELADO'},
  ];

  final List<String> tabs = [
    'Usuários',
    'Categorias',
    'Eventos',
    'Mensagens',
    'Presenças'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  void _navigateToTab(int index) {
    Navigator.pop(context); // fecha o drawer
    setState(() {
      _tabController.index = index;
    });
  }

  Widget _buildUsuariosTab() {
    return ListView.builder(
      itemCount: usuarios.length,
      itemBuilder: (context, i) {
        final u = usuarios[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: primaryColor,
              child: Text(u['nome'][0]),
            ),
            title: Text(u['nome']),
            subtitle: Text(
                '${u['email']} - ${u['nivelAcesso']} - Status: ${u['statusUsuario']}'),
          ),
        );
      },
    );
  }

  Widget _buildCategoriasTab() {
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, i) {
        final c = categorias[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Icon(Icons.category, color: primaryColor),
            title: Text(c['nome']),
          ),
        );
      },
    );
  }

  Widget _buildEventosTab() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, i) {
        final e = eventos[i];
        final categoriaNome = categorias.firstWhere(
            (c) => c['id'] == e['categoria_id'],
            orElse: () => {'nome': 'N/A'})['nome'];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(e['nome']),
            subtitle: Text(
                'Data: ${e['dataEvento']} - Local: ${e['localEnvento']} - Categoria: $categoriaNome\nStatus: ${e['statusEvento']} - Preço: R\$${e['preco']?.toStringAsFixed(2) ?? '0.00'}'),
            isThreeLine: true,
            leading: Icon(Icons.event, color: primaryColor),
          ),
        );
      },
    );
  }

  Widget _buildMensagensTab() {
    return ListView.builder(
      itemCount: mensagens.length,
      itemBuilder: (context, i) {
        final m = mensagens[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title: Text(m['emissor']),
            subtitle: Text(
                '${m['texto']}\nEmail: ${m['email']} - Status: ${m['statusMensagem']}'),
            isThreeLine: true,
            leading: Icon(Icons.message, color: primaryColor),
          ),
        );
      },
    );
  }

  Widget _buildPresencasTab() {
    return ListView.builder(
      itemCount: presencas.length,
      itemBuilder: (context, i) {
        final p = presencas[i];
        final evento = eventos.firstWhere((e) => e['id'] == p['evento_id'],
            orElse: () => {'nome': 'N/A'});
        final usuario = usuarios.firstWhere((u) => u['id'] == p['usuario_id'],
            orElse: () => {'nome': 'N/A'});
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title:
                Text('Usuário: ${usuario['nome']} - Evento: ${evento['nome']}'),
            subtitle: Text('Status Presença: ${p['statusPresenca']}'),
            leading: Icon(Icons.people, color: primaryColor),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard - Gestão de Eventos'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ...tabs.asMap().entries.map((entry) {
              int idx = entry.key;
              String tabName = entry.value;
              return ListTile(
                leading: Icon(
                  _getIconForTab(tabName),
                  color: idx == _tabController.index
                      ? primaryColor
                      : Colors.black54,
                ),
                title: Text(
                  tabName,
                  style: TextStyle(
                    color: idx == _tabController.index
                        ? primaryColor
                        : Colors.black87,
                    fontWeight: idx == _tabController.index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                onTap: () => _navigateToTab(idx),
              );
            }).toList(),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Implementar lógica de logout aqui, se precisar
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Logout efetuado!'),
                    backgroundColor: primaryColor,
                  ),
                );
              },
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
          _buildMensagensTab(),
          _buildPresencasTab(),
        ],
      ),
    );
  }

  IconData _getIconForTab(String tab) {
    switch (tab) {
      case 'Usuários':
        return Icons.person;
      case 'Categorias':
        return Icons.category;
      case 'Eventos':
        return Icons.event;
      case 'Mensagens':
        return Icons.message;
      case 'Presenças':
        return Icons.people;
      default:
        return Icons.device_unknown;
    }
  }
}
