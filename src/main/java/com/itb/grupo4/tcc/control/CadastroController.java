package control;

import model.Cadastro;
import service.CadastroService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.springframework.http.ResponseEntity;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/v1") // Altera o mapeamento base
public class CadastroController {

    private final CadastroService cadastroService;

    public CadastroController(CadastroService cadastroService) {
        this.cadastroService = cadastroService;
    }

    @GetMapping("/cadastro")
    public ResponseEntity<List<Cadastro>> listarTodosCadastros() {
        return ResponseEntity.ok(cadastroService.listarTodosCadastros());
    }

    @PostMapping("/cadastro")
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