import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ingresso_screen.dart';

class PagamentoScreen extends StatefulWidget {
  final Map<String, dynamic> evento;

  const PagamentoScreen({super.key, required this.evento});

  @override
  State<PagamentoScreen> createState() => _PagamentoScreenState();
}

class _PagamentoScreenState extends State<PagamentoScreen> {
  final Color primaryColor = const Color(0xFFDC143C);
  String _metodoPagamento = 'pix';
  bool _mostrarCodigoPix = true;
  final String _codigoPix = '00020126580014br.gov.bcb.pix013636c7f4d8-a2e3-4d5f-9c8b-1e2f3a4b5c6d52040000530398654041.005802BR5925CORACAO GENEROSO EVENTOS6009SAO PAULO62070503***6304';

  void _processarPagamento() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFFDC143C)),
            SizedBox(height: 16),
            Text('Processando pagamento...'),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IngressoScreen(
              evento: widget.evento,
              metodoPagamento: _metodoPagamento,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.evento['nome'],
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Data: ${widget.evento['dataEvento']}'),
                    Text('Local: ${widget.evento['localEvento']}'),
                    const SizedBox(height: 8),
                    Text(
                      'Valor: R\$ ${widget.evento['preco'].toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Forma de Pagamento:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.pix, color: Color(0xFF32BCAD)),
                  SizedBox(width: 8),
                  Text('PIX'),
                ],
              ),
              leading: Radio<String>(
                value: 'pix',
                groupValue: _metodoPagamento,
                onChanged: (value) => setState(() {
                  _metodoPagamento = value!;
                  _mostrarCodigoPix = value == 'pix';
                }),
              ),
            ),
            
            if (_mostrarCodigoPix)
              const SizedBox(height: 16),
            
            if (_mostrarCodigoPix)
              Card(
                color: const Color(0xFFF0F8FF),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.pix, color: Color(0xFF32BCAD)),
                          SizedBox(width: 8),
                          Text('Código PIX para Pagamento', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _codigoPix,
                              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: _codigoPix));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Código PIX copiado!'),
                                        backgroundColor: Color(0xFF32BCAD),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.copy, size: 16),
                                  label: const Text('Copiar'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Copie o código acima e cole no seu app de pagamentos',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.blue),
                  SizedBox(width: 8),
                  Text('Cartão de Débito'),
                ],
              ),
              leading: Radio<String>(
                value: 'debito',
                groupValue: _metodoPagamento,
                onChanged: (value) => setState(() {
                  _metodoPagamento = value!;
                  _mostrarCodigoPix = false;
                }),
              ),
            ),
            
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.credit_card, color: Colors.orange),
                  SizedBox(width: 8),
                  Text('Cartão de Crédito'),
                ],
              ),
              leading: Radio<String>(
                value: 'credito',
                groupValue: _metodoPagamento,
                onChanged: (value) => setState(() {
                  _metodoPagamento = value!;
                  _mostrarCodigoPix = false;
                }),
              ),
            ),
            
            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _processarPagamento,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: Text('Pagar R\$ ${widget.evento['preco'].toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}