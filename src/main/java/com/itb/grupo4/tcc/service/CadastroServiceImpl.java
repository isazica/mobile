package com.itb.grupo4.tcc.service;

<<<<<<< HEAD
import exceptions.BadRequest;
import exceptions.NotFound;
import model.Cadastro;
import repository.CadastroRepository;
=======
import com.itb.grupo4.tcc.exceptions.BadRequest;
import com.itb.grupo4.tcc.exceptions.NotFound;
import com.itb.grupo4.tcc.model.Cadastro;
import com.itb.grupo4.tcc.repository.CadastroRepository;
import com.itb.grupo4.tcc.service.CadastroService;
>>>>>>> 9d10dda (teste)
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CadastroServiceImpl implements CadastroService {

    private final CadastroRepository cadastroRepository;

    public CadastroServiceImpl(CadastroRepository cadastroRepository) {
        this.cadastroRepository = cadastroRepository;
    }

    @Override
    public Cadastro salvarCadastro(Cadastro cadastro) {
        cadastro.setCodStatus(true);
        cadastro.validar(); // Chama o método validar()
        if (!cadastro.isValid()) { // Verifica se o cadastro é válido
            throw new BadRequest(cadastro.getMensagemErro());
        }
        return cadastroRepository.save(cadastro);
    }

    @Override
    public boolean deletarCadastro(Long id) {
        if (cadastroRepository.existsById(id)) {
            cadastroRepository.deleteById(id);
        } else {
            throw new NotFound("Cadastro não encontrado com o id " + id);
        }
        return true;
    }

    @Override
    public List<Cadastro> listarTodosCadastros() {
        return cadastroRepository.findAll();
    }

    @Override
    public Cadastro listarCadastroPorId(Long id) {
        return cadastroRepository.findById(id).orElseThrow(() ->
                new NotFound("Cadastro não encontrado com o id " + id));
    }

    @Override
    public Cadastro atualizarCadastro(Cadastro cadastro, Long id) {
        cadastro.validar(); // Chama o método validar()
        if (!cadastro.isValid()) { // Verifica se o cadastro é válido
            throw new BadRequest(cadastro.getMensagemErro());
        }
        if (!cadastroRepository.existsById(id)) {
            throw new NotFound("Cadastro não encontrado com o id " + id);
        }
        Cadastro cadastroDb = cadastroRepository.findById(id).get();
        cadastroDb.setNome(cadastro.getNome());
        // Atualize outros campos conforme necessário

        return cadastroRepository.save(cadastroDb);
    }
}