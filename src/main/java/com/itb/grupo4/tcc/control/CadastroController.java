package com.itb.grupo4.tcc.control;

import com.itb.grupo4.tcc.model.Cadastro;
import com.itb.grupo4.tcc.service.CadastroService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.http.ResponseEntity;

import java.net.URI;
import java.util.List;

@Controller
@RequestMapping("/api/v1/cadastro") // Altera o mapeamento base
public class CadastroController {

    private final CadastroService cadastroService;

    public CadastroController(CadastroService cadastroService) {
        this.cadastroService = cadastroService;
    }

    @GetMapping
    public ResponseEntity<List<Cadastro>> listarTodosCadastros() {
        return ResponseEntity.ok(cadastroService.listarTodosCadastros());
    }

    @PostMapping
    public ResponseEntity<Cadastro> salvarCadastro(@RequestBody Cadastro cadastro) {
        URI uri = URI.create(ServletUriComponentsBuilder.fromCurrentContextPath()
                .path("/api/v1/cadastro").toUriString());
        return ResponseEntity.created(uri).body(cadastroService.salvarCadastro(cadastro));
    }

    @GetMapping("/cadastroPage")
    public String mostrarCadastroPage() {
        return "cadastro";
    }
}