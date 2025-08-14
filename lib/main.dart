import 'package:flutter/material.dart';

import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/suporte_screen.dart';
import 'screens/meus_eventos_screen.dart';
import 'screens/configuracoes_screen.dart';
import 'screens/sobre_nos_screen.dart';
import 'screens/favoritos_screen.dart';
import 'screens/historico_screen.dart';
import 'screens/detalhes_evento_screen.dart';
import 'screens/politica_privacidade_screen.dart';
import 'screens/termos_uso_screen.dart';
import 'screens/meus_ingressos_screen.dart';
import 'screens/feedback_screen.dart';

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
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD32F2F),
          foregroundColor: Colors.white,
          elevation: 3,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
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
        cardTheme: CardTheme(
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
        '/politica-privacidade': (context) => const PoliticaPrivacidadeScreen(),
        '/termos-uso': (context) => const TermosUsoScreen(),
      },
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final Color primaryColor = const Color(0xFFD32F2F);
  final Color secondaryColor = const Color(0xFF616161);
  final Color accentColor = const Color(0xFFF8BBD9);
  
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> eventos = [
    {
      'id': 1,
      'nome': 'Bazar de Natal',
      'descricao': 'Bazar beneficente especial de Natal com roupas, brinquedos, livros e artesanatos. Toda a renda será destinada para famílias carentes da comunidade. Venha participar desta ação solidária e ajude a tornar o Natal de muitas crianças mais feliz!',
      'localEvento': 'Centro Comunitário',
      'dataEvento': '2025-12-10',
      'periodo': 'Manhã',
      'preco': 10.00,
      'categoria': 'Bazar',
      'vagas': 50,
      'statusEvento': 'ATIVO',
    },
    {
      'id': 2,
      'nome': 'Show de Rock',
      'descricao': 'Show de rock beneficente com as melhores bandas locais da região. Uma noite inesquecível de música e solidariedade para arrecadar fundos para o projeto de música para jovens em situação de vulnerabilidade social.',
      'localEvento': 'Arena Municipal',
      'dataEvento': '2025-08-15',
      'periodo': 'Noite',
      'preco': 50.00,
      'categoria': 'Show',
      'vagas': 200,
      'statusEvento': 'ATIVO',
    },
    {
      'id': 3,
      'nome': 'Almoço Comunitário',
      'descricao': 'Almoço solidário aberto para toda a comunidade. Um momento de confraternização e união, onde compartilhamos não apenas uma refeição, mas também histórias, sorrisos e esperança. Todos são bem-vindos!',
      'localEvento': 'Parque Central',
      'dataEvento': '2025-09-01',
      'periodo': 'Tarde',
      'preco': 15.00,
      'categoria': 'Almoço',
      'vagas': 100,
      'statusEvento': 'ATIVO',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final List<String> menuOptions = [
    'Perfil', 'Meus Eventos', 'Meus Ingressos', 'Favoritos', 'Histórico', 'Dar Meu Feedback', 'Suporte', 'Configurações', 'Sobre Nós'
  ];

  List<dynamic> get filteredResults {
    if (_searchQuery.isEmpty) {
      return eventos.where((e) => e['statusEvento'] == 'ATIVO').toList();
    }
    
    List<dynamic> results = [];
    
    // Buscar nos eventos
    results.addAll(eventos
        .where((e) =>
            e['statusEvento'] == 'ATIVO' &&
            (e['nome'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                e['descricao'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
                e['localEvento'].toLowerCase().contains(_searchQuery.toLowerCase())))
        .toList());
    
    // Buscar nas opções do menu
    results.addAll(menuOptions
        .where((option) => option.toLowerCase().contains(_searchQuery.toLowerCase()))
        .map((option) => {'type': 'menu', 'name': option})
        .toList());
    
    return results;
  }

  Widget _buildSearchBar() {
    return Container(
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
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xFFFCE4EC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('❤️', style: TextStyle(fontSize: 24)),
                      const SizedBox(width: 8),
                      Text(
                        'Sobre Nossos Eventos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'O Coração Generoso promove eventos solidários que transformam vidas e fortalecem nossa comunidade. Cada evento é uma oportunidade de fazer a diferença!',
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('🎯', style: TextStyle(fontSize: 32)),
                        const SizedBox(height: 8),
                        const Text(
                          'Missão',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Conectar pessoas através de eventos solidários',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('🤝', style: TextStyle(fontSize: 32)),
                        const SizedBox(height: 8),
                        const Text(
                          'Comunidade',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mais de 500 voluntários ativos',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final results = filteredResults;
    
    if (results.isEmpty) {
      return Container(
        margin: const EdgeInsets.all(16),
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
          children: [
            const Text('🔍', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              'Nenhum resultado encontrado para "$_searchQuery"',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resultados da pesquisa',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          ...results.map((result) {
            if (result['type'] == 'menu') {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(_getMenuIcon(result['name']), color: primaryColor),
                  title: Text(result['name']),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _navigateToMenu(result['name']),
                ),
              );
            } else {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 6,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesEventoScreen(evento: result),
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getEventIcon(result['nome']),
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
                                result['nome'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                result['localEvento'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }).toList(),
        ],
      ),
    );
  }

  IconData _getMenuIcon(String menuName) {
    switch (menuName) {
      case 'Perfil': return Icons.person;
      case 'Meus Eventos': return Icons.event;
      case 'Meus Ingressos': return Icons.confirmation_number;
      case 'Favoritos': return Icons.favorite;
      case 'Histórico': return Icons.history;
      case 'Dar Meu Feedback': return Icons.rate_review;
      case 'Suporte': return Icons.support_agent;
      case 'Configurações': return Icons.settings;
      case 'Sobre Nós': return Icons.info;
      default: return Icons.menu;
    }
  }

  void _navigateToMenu(String menuName) {
    switch (menuName) {
      case 'Perfil':
        Navigator.pushNamed(context, '/perfil');
        break;
      case 'Meus Eventos':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MeusEventosScreen()));
        break;
      case 'Meus Ingressos':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MeusIngressosScreen()));
        break;
      case 'Favoritos':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritosScreen()));
        break;
      case 'Histórico':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoricoScreen()));
        break;
      case 'Dar Meu Feedback':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const FeedbackScreen()));
        break;
      case 'Suporte':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SuporteScreen()));
        break;
      case 'Configurações':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfiguracoesScreen()));
        break;
      case 'Sobre Nós':
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SobreNosScreen()));
        break;
    }
  }

  Widget _buildEventosVitrine() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🎆', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 8),
              Text(
                'Nossas Novidades',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: eventos.map((evento) {
                  return Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesEventoScreen(evento: evento),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.white, Color(0xFFFCE4EC)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    _getEventIcon(evento['nome']),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  evento['nome'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  evento['descricao'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        evento['dataEvento'],
                                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    evento['preco'] == 0 ? 'GRATUITO' : 'R\$ ${evento['preco'].toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getEventIcon(String nome) {
    if (nome.toLowerCase().contains('bazar')) return Icons.shopping_bag;
    if (nome.toLowerCase().contains('show') || nome.toLowerCase().contains('rock')) return Icons.music_note;
    if (nome.toLowerCase().contains('almoço') || nome.toLowerCase().contains('comida')) return Icons.restaurant;
    return Icons.event;
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: primaryColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'CORAÇÃO GENEROSO',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Abrindo Instagram...')),
                  );
                },
                child: const Text(
                  '@coracaogeneroso',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Abrindo Facebook...')),
                  );
                },
                child: const Text(
                  'Facebook',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ligando para (11) 99999-9999...')),
                  );
                },
                child: const Text(
                  '(11) 99999-9999',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '© 2025 Coração Generoso',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('❤️', style: TextStyle(fontSize: 24)),
            SizedBox(width: 8),
            Text('CORAÇÃO GENEROSO'),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFD32F2F), Color.fromRGBO(211, 47, 47, 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('❤️', style: TextStyle(fontSize: 50)),
                  SizedBox(height: 8),
                  Text(
                    'CORAÇÃO GENEROSO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Bem-vindo!',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFFFCE4EC),
              ),
              child: ListTile(
                leading: const Icon(Icons.home, color: Color(0xFFD32F2F)),
                title: const Text('Início'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFD32F2F)),
                title: const Text('Perfil'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/perfil');
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.event, color: Color(0xFFD32F2F)),
                title: const Text('Meus Eventos'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MeusEventosScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.confirmation_number, color: Color(0xFFD32F2F)),
                title: const Text('Meus Ingressos'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MeusIngressosScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.favorite, color: Color(0xFFD32F2F)),
                title: const Text('Favoritos'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FavoritosScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.history, color: Color(0xFFD32F2F)),
                title: const Text('Histórico'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoricoScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.rate_review, color: Color(0xFFD32F2F)),
                title: const Text('Dar Meu Feedback'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.support_agent, color: Color(0xFFD32F2F)),
                title: const Text('Suporte'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SuporteScreen()),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Divider(),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFFD32F2F)),
                title: const Text('Configurações'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ConfiguracoesScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.info, color: Color(0xFFD32F2F)),
                title: const Text('Sobre Nós'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SobreNosScreen()),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.red[50],
              ),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Sair', style: TextStyle(color: Colors.red)),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearchBar(),
            _searchQuery.isNotEmpty ? _buildSearchResults() : _buildInfoSection(),
            _searchQuery.isEmpty ? _buildEventosVitrine() : const SizedBox(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }
}