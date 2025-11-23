INSERT INTO pessoa (cpf, matricula, email, nome, cidade, cep)
VALUES
('111.111.111-11', 'MAT001', 'prof1@uni.com', 'Professor A', 'Recife', '50000-000'),
('222.222.222-22', 'MAT002', 'prof2@uni.com', 'Professor B', 'Olinda', '53000-000'),
('333.333.333-33', 'MAT003', 'aluno1@uni.com', 'Aluno A', 'Recife', '50000-100'),
('444.444.444-44', 'MAT004', 'aluno2@uni.com', 'Jaboatão', '54000-200'),
('555.555.555-55', 'MAT005', 'aluno3@uni.com', 'Paulista', '53400-300'),
('666.666.666-66', 'MAT006', 'aluno4@uni.com', 'Camaragibe', '54750-400');

INSERT INTO professor (id_pessoa, turmas, departamento)
VALUES
(1, 'ADS101, ADS202', 'Tecnologia'),
(2, 'ENG301', 'Engenharia');

INSERT INTO professor_titulacao (id_pessoa, titulacao)
VALUES
(1, 'Mestrado'),
(1, 'Doutorado'),
(1, 'Pós-Doutorado'),
(2, 'Especialização'),
(2, 'Mestrado'),
(2, 'Doutorado');

INSERT INTO aluno (id_pessoa, periodo, id_professor)
VALUES
(3, '3º período', 1),
(4, '4º período', 1),
(5, '5º período', 2),
(6, '6º período', 2);

INSERT INTO empresa (nome)
VALUES
('TechPlus Solutions'),
('IntegraSoft'),
('MegaData'),
('LogiWorks'),
('EcoLabs'),
('NetMaster');

INSERT INTO funcionario (id_empresa, nome)
VALUES
(1, 'Carlos Silva'),
(2, 'Mariana Souza'),
(3, 'João Mendes'),
(4, 'Fernanda Rocha'),
(5, 'Rafael Gomes'),
(6, 'Beatriz Lima');

INSERT INTO supervisor_estagio (id_funcionario)
VALUES
(1),
(2),
(3),
(4),
(5),
(6);

INSERT INTO relatorio (id_aluno, titulo, data, candidata, horario)
VALUES
(3, 'Relatório 1', '2025-01-10', 'Empresa A', '08:00'),
(4, 'Relatório 2', '2025-01-12', 'Empresa B', '09:00'),
(5, 'Relatório 3', '2025-01-14', 'Empresa C', '10:00'),
(6, 'Relatório 4', '2025-01-16', 'Empresa D', '11:00'),
(3, 'Relatório Extra', '2025-01-18', 'Empresa E', '14:00'),
(4, 'Relatório Final', '2025-01-20', 'Empresa F', '15:00');

INSERT INTO contrato (id_relatorio, id_supervisor, carga_horaria, data_inicio, data_finalizacao)
VALUES
(1, 1, 120, '2025-02-01', '2025-05-01'),
(2, 2, 100, '2025-02-05', '2025-05-05'),
(3, 3, 150, '2025-02-10', '2025-05-10'),
(4, 4, '200', '2025-02-15', '2025-05-15'),
(5, 5, 80, '2025-02-20', '2025-05-20'),
(6, 6, 90, '2025-02-25', '2025-05-25');

INSERT INTO vaga (id_empresa, descricao)
VALUES
(1, 'Desenvolvedor Júnior'),
(2, 'Analista de Dados'),
(3, 'Suporte Técnico'),
(4, 'Estágio em Redes'),
(5, 'Estágio em Sustentabilidade'),
(6, 'Tester QA');

INSERT INTO candidatura (id_aluno, id_vaga, horario)
VALUES
(3, 1, '09:00'),
(4, 2, '10:00'),
(5, 3, '14:00'),
(6, 4, '15:00'),
(3, 5, '16:00'),
(4, 6, '17:00');