import 'package:flutter/material.dart';


class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // LOGO OU NOME
            Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/logo.png', // substitua pelo logo da ONG
                  height: 100,
                ),
                const SizedBox(height: 12),
                const Text(
                  "ONG Esperança Viva",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            // FRASE DE IMPACTO
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Juntos transformamos vidas com solidariedade.\nParticipe dos nossos eventos!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),

            // IMAGEM SIMBÓLICA
            Image.asset(
              'assets/hands.png', // imagem decorativa, ex: mãos unidas
              height: 180,
            ),

            // BOTÕES
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/eventos');
                  },
                  child: const Text(
                    "Ver eventos",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
