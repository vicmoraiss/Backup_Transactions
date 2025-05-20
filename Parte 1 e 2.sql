use biblioteca;
-- code 1
SET autocommit = 0;
DELIMITER $$
IN opcao int, IN id int

		 IF 1 THEN
			SELECT * FROM emprestimo WHERE idEmprestimo =id;
			insert into emprestimo(idEmprestimo,livro,locador,situacao,dtEmprestimo,dtDevolucao) values 		
        (5,5,3,'Emprestimo','01/11','10/12');
			SAVEPOINT save_p1;
            ELSE 
             IF 2 THEN
			UPDATE emprestimo SET situacao = 'Devolvido' WHERE idEmprestimo = id;
               SAVEPOINT savep2;
			ELSE 
            ROLLBACK;
            END IF;
end IF;
$$ DELIMITER ;
-- Code 2

DELIMITER $$
CREATE PROCEDURE CRUD(
	IN opcao int, IN id int
)
BEGIN	
	
			 IF 1 THEN
			SELECT * FROM emprestimo WHERE idEmprestimo =id; 
			insert into emprestimo(idEmprestimo,livro,locador,situacao,dtEmprestimo,dtDevolucao) values 		
        (5,5,3,'Emprestimo','01/11','10/12');
			SAVEPOINT save_p1;
            
            ELSE 

             IF 2 THEN
			UPDATE emprestimo SET situacao = 'Devolvido' WHERE idEmprestimo = id;
               SAVEPOINT savep2;
			ELSE 
            ROLLBACK;
    
end IF;
        END IF;
END$$ 
DELIMITER ;