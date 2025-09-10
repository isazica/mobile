import '../models/evento_model.dart';

class SearchService {
  static List<dynamic> getFilteredResults(String searchQuery) {
    if (searchQuery.isEmpty) {
      return EventoModel.eventos.where((e) => e['statusEvento'] == 'ATIVO').toList();
    }

    List<dynamic> results = [];

    // Buscar nos eventos
    results.addAll(EventoModel.eventos
        .where((e) =>
            e['statusEvento'] == 'ATIVO' &&
            (e['nome'].toLowerCase().contains(searchQuery.toLowerCase()) ||
                e['descricao'].toLowerCase().contains(searchQuery.toLowerCase()) ||
                e['localEvento'].toLowerCase().contains(searchQuery.toLowerCase())))
        .toList());

    // Buscar nas opções do menu
    results.addAll(EventoModel.menuOptions
        .where((option) => option.toLowerCase().contains(searchQuery.toLowerCase()))
        .map((option) => {'type': 'menu', 'name': option})
        .toList());

    return results;
  }
}