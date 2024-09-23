package service;

import com.itb.grupo4.tcc.model.Cadastro;
import java.util.List;

public interface CadastroService {
    Cadastro salvarCadastro(Cadastro cadastro);
    boolean deletarCadastro(Long id);
    List<Cadastro> listarTodosCadastros();
    Cadastro listarCadastroPorId(Long id);
    Cadastro atualizarCadastro(Cadastro cadastro, Long id);
}