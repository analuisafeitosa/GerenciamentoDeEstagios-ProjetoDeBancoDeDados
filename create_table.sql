CREATE TABLE IF NOT EXISTS pessoa (
    id_pessoa SERIAL PRIMARY KEY,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    matricula VARCHAR(20),
    email VARCHAR(150),
    nome VARCHAR(150) NOT NULL,
    cidade VARCHAR(100),
    cep VARCHAR(10)
);

CREATE TABLE IF NOT EXISTS professor (
    id_pessoa INTEGER PRIMARY KEY,
    turmas VARCHAR(100),
    departamento VARCHAR(100),
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa)
);

CREATE TABLE IF NOT EXISTS aluno (
    id_pessoa INTEGER PRIMARY KEY,
    periodo VARCHAR(20),
    id_professor INTEGER,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa(id_pessoa),
    FOREIGN KEY (id_professor) REFERENCES professor(id_pessoa)
);

CREATE TABLE IF NOT EXISTS empresa (
    id_empresa SERIAL PRIMARY KEY,
    nome VARCHAR(150)
);

CREATE TABLE IF NOT EXISTS funcionario (
    id_funcionario SERIAL PRIMARY KEY,
    id_empresa INTEGER,
    nome VARCHAR(150),
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE IF NOT EXISTS supervisor_estagio (
    id_supervisor SERIAL PRIMARY KEY,
    id_funcionario INTEGER,
    FOREIGN KEY (id_funcionario) REFERENCES funcionario(id_funcionario)
);

CREATE TABLE IF NOT EXISTS relatorio (
    id_relatorio SERIAL PRIMARY KEY,
    id_aluno INTEGER,
    titulo VARCHAR(200),
    data DATE,
    candidata VARCHAR(150),
    horario VARCHAR(20),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_pessoa)
);

CREATE TABLE IF NOT EXISTS contrato (
    id_contrato SERIAL PRIMARY KEY,
    id_relatorio INTEGER,
    id_supervisor INTEGER,
    carga_horaria INTEGER,
    data_inicio DATE,
    data_finalizacao DATE,
    FOREIGN KEY (id_relatorio) REFERENCES relatorio(id_relatorio),
    FOREIGN KEY (id_supervisor) REFERENCES supervisor_estagio(id_supervisor)
);

CREATE TABLE IF NOT EXISTS professor_titulacao (
    id_pessoa INTEGER,
    titulacao VARCHAR(100),
    PRIMARY KEY (id_pessoa, titulacao),
    FOREIGN KEY (id_pessoa) REFERENCES professor(id_pessoa)
);

CREATE TABLE IF NOT EXISTS vaga (
    id_vaga SERIAL PRIMARY KEY,
    id_empresa INTEGER,
    descricao VARCHAR(200),
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa)
);

CREATE TABLE IF NOT EXISTS candidatura (
    id_aluno INTEGER,
    id_vaga INTEGER,
    horario VARCHAR(20),
    PRIMARY KEY (id_aluno, id_vaga),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_pessoa),
    FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga)
);