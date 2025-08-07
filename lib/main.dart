import 'package:flutter/material.dart';

import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/configuracoes_screen.dart';
import 'screens/sobre_nos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CORAÇÃO GENEROSO', 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD32F2F),  // Vermelho principal mais escuro
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),  // Fundo cinza claro
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),  // Vermelho principal
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F), // Vermelho principal
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFD32F2F)),
          ),
          labelStyle: TextStyle(color: Color(0xFF616161)),
          floatingLabelStyle: TextStyle(color: Color(0xFFD32F2F)),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFD32F2F),
          selectionColor: Color(0xFFFFCDD2),
          selectionHandleColor: Color(0xFFD32F2F),
        ),
        cardTheme: const CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/telaInicial': (context) => const DashboardScreen(),
        '/perfil': (context) => const PerfilScreen(),
        '/configuracoes': (context) => const ConfiguracoesScreen(),
        '/sobre-nos': (context) => const SobreNosScreen(),
      },
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
  final Color primaryColor = const Color(0xFFD32F2F);    // Vermelho principal
  final Color secondaryColor = const Color(0xFF616161);   // Cinza escuro
  final Color accentColor = const Color(0xFFF8BBD9);      // Rosa claro
  final Color lightGrayColor = const Color(0xFFE0E0E0);   // Cinza claro



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
              backgroundColor: isSelected ? primaryColor : accentColor,
              foregroundColor: isSelected ? Colors.white : secondaryColor,
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
                    const SizedBox(height: 6),
                    Text(
                      '${e['localEvento']} • ${e['dataEvento']} • ${e['periodo']}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'R\$ ${e['preco'].toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
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
              final isEmissorSuporte = msg['emissor'] == 'Suporte';
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                alignment:
                    isEmissorSuporte ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isEmissorSuporte ? Colors.grey[300] : primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isEmissorSuporte ? 0 : 20),
                      bottomRight: Radius.circular(isEmissorSuporte ? 20 : 0),
                    ),
                  ),
                  child: Text(
                    msg['texto'],
                    style: TextStyle(
                        color: isEmissorSuporte ? Colors.black87 : Colors.white,
                        fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _mensagemController,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua mensagem...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  final texto = _mensagemController.text.trim();
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
                child: const Icon(Icons.send),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPresencasTab() {
    return Center(
      child: Text(
        'Presenças ainda não implementado',
        style: TextStyle(fontSize: 18, color: Colors.grey[700]),
      ),
    );
  }

  List<Widget> get _tabViews => [
        _buildCategoriasTab(),
        _buildEventosTab(),
        _buildSuporteTab(),
        _buildPresencasTab(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite, color: accentColor, size: 28),
            const SizedBox(width: 8),
            const Text('CORAÇÃO GENEROSO'),
          ],
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: tabs.map((t) => Tab(text: t)).toList(),
          isScrollable: true,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              child: const Center(
                child: Text(
                  'MENU',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/perfil');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/configuracoes');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Sobre Nós'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/sobre-nos');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabViews,
      ),
    );
  }
}
