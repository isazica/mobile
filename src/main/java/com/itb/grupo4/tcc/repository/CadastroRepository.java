<<<<<<< HEAD
package repository;

import model.Cadastro;
=======
package com.itb.grupo4.tcc.repository;

import com.itb.grupo4.tcc.model.Cadastro;
>>>>>>> 9d10dda (teste)
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CadastroRepository extends JpaRepository<Cadastro, Long> {
}
