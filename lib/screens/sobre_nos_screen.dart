import 'package:flutter/material.dart';

class SobreNosScreen extends StatefulWidget {
  const SobreNosScreen({super.key});

  @override
  State<SobreNosScreen> createState() => _SobreNosScreenState();
}

class _SobreNosScreenState extends State<SobreNosScreen> {
  final Color primaryColor = const Color(0xFFD32F2F);
  final Color secondaryColor = const Color(0xFF616161);
  final Color accentColor = const Color(0xFFF8BBD9);
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> carrosselImages = [
    'https://images.unsplash.com/photo-1559027615-cd4628902d4a?auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1582213782179-e0d53f98f2ca?auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?auto=format&fit=crop&w=800&q=60',
    'https://images.unsplash.com/photo-1469571486292-0ba58a3f068b?auto=format&fit=crop&w=800&q=60',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sobre Nós'),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildCarrossel(),
            _buildContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarrossel() {
    return Container(
      height: 250,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: carrosselImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    carrosselImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(Icons.image, size: 60, color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                carrosselImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? primaryColor : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'CORAÇÃO GENEROSO',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSection(
            icon: Icons.favorite,
            title: 'Nossa Missão',
            description: 'Dar visibilidade e arrecadar meios de ajuda para a ONG Coração Generoso, conectando pessoas generosas com causas que transformam vidas.',
          ),
          _buildSection(
            icon: Icons.visibility,
            title: 'Objetivo do App',
            description: 'Este aplicativo foi criado para facilitar a participação em eventos beneficentes, aumentar a visibilidade das ações da ONG e simplificar o processo de doações e voluntariado.',
          ),
          _buildSection(
            icon: Icons.people,
            title: 'Comunidade',
            description: 'Somos uma comunidade de pessoas que acreditam no poder da solidariedade. Juntos, organizamos eventos, bazares, almoços comunitários e shows beneficentes.',
          ),
          _buildSection(
            icon: Icons.handshake,
            title: 'Como Ajudar',
            description: 'Participe dos nossos eventos, faça doações, seja voluntário ou simplesmente compartilhe nossa causa. Cada gesto conta para fazer a diferença na vida de quem precisa.',
          ),
          const SizedBox(height: 32),
          _buildContactInfo(),
        ],
      ),
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Entre em Contato',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.email, color: primaryColor),
              const SizedBox(width: 12),
              const Text('contato@coracaogeneroso.org'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone, color: primaryColor),
              const SizedBox(width: 12),
              const Text('(11) 99999-9999'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, color: primaryColor),
              const SizedBox(width: 12),
              const Expanded(child: Text('São Paulo, SP - Brasil')),
            ],
          ),
        ],
      ),
    );
  }
}