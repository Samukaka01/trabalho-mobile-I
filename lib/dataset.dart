import 'dart:convert';
import 'package:flutter/cupertino.dart';

List<Funcionario> funcionarios = [
  Funcionario(
    id: 1,
    nome: "Alice Silva",
    email: "alice@email.com",
    telefone: "999999999",
    cpf: "12312312312",
    endereco: "Rua A, 123",
    dataNascimento: "1990-01-01",
    cargo: "Desenvolvedora",
  ),
  Funcionario(
    id: 2,
    nome: "Bruno Costa",
    email: "bruno@email.com",
    telefone: "888888888",
    cpf: "32132132132",
    endereco: "Rua B, 456",
    dataNascimento: "1995-05-12",
    cargo: "Analista",
  ),
];

class Tarefa {
  final int id;
  String nome;
  String descTarefa;
  Funcionario funcionario;
  int nivelTarefa;
  String tipoTarefa;
  String periodicidade;
  String perioAvaliacao;
  String caminhoTarefa;
  DateTime? dataTarefaCriada;
  DateTime? dataVencimentoTarefa;

  Tarefa({
    required this.id,
    required this.nome,
    required this.descTarefa,
    required this.funcionario,
    required this.nivelTarefa,
    required this.tipoTarefa,
    required this.periodicidade,
    required this.perioAvaliacao,
    required this.caminhoTarefa,
    required this.dataTarefaCriada,
    required this.dataVencimentoTarefa,
  });

  factory Tarefa.fromMap(Map map) {
    final funcionarioID = map['funcionario'];
    final funcionarioEncontrado = funcionarios.firstWhere(
      (f) => f.id == funcionarioID,
      orElse: () => Funcionario(
        id: 0,
        nome: "Funcionário Não Encontrado",
        email: "",
        telefone: "",
        cpf: "",
        endereco: "",
        dataNascimento: "",
        cargo: "",
      ),
    );

    return Tarefa(
      id: map['id'] is int ? map['id'] : int.tryParse('${map['id']}') ?? 0,
      nome: map['nome']?.toString() ?? '',
      descTarefa: map['descTarefa']?.toString() ?? '',
      funcionario: funcionarioEncontrado,
      nivelTarefa: map['nivelTarefa'] is int
          ? map['nivelTarefa']
          : int.tryParse('${map['nivelTarefa']}') ?? 0,
      tipoTarefa: map['tipoTarefa']?.toString() ?? '',
      periodicidade: map['periodicidade']?.toString() ?? '',
      perioAvaliacao: map['perioAvaliacao']?.toString() ?? '',
      caminhoTarefa: map['caminhoTarefa']?.toString() ?? '',
      dataTarefaCriada: map['dataTarefaCriada'] != null
          ? DateTime.tryParse(map['dataTarefaCriada'])
          : null,
      dataVencimentoTarefa: map['dataVencimentoTarefa'] != null
          ? DateTime.tryParse(map['dataVencimentoTarefa'])
          : null,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'nome': nome,
      'descTarefa': descTarefa,
      'funcionario': funcionario.id,
      'nivelTarefa': nivelTarefa,
      'tipoTarefa': tipoTarefa,
      'periodicidade': periodicidade,
      'perioAvaliacao': perioAvaliacao,
      'caminhoTarefa': caminhoTarefa,
      'dataTarefaCriada': dataTarefaCriada?.toIso8601String(),
      'dataVencimentoTarefa': dataVencimentoTarefa?.toIso8601String(),
    };
  }

  factory Tarefa.fromJson(String source) =>
      Tarefa.fromMap(json.decode(source));
  String toJson() => json.encode(toMap());
}


class Funcionario {
  final int id;
  String nome;
  String email;
  String telefone;
  String cpf;
  String endereco;
  String dataNascimento;
  String cargo;

  Funcionario({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.cpf,
    required this.endereco,
    required this.dataNascimento,
    required this.cargo,
  });

  factory Funcionario.fromMap(Map map) {
    return Funcionario(
      id: map['id'] is int ? map['id'] : int.tryParse('${map['id']}') ?? 0,
      nome: map['nome']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      telefone: map['telefone']?.toString() ?? '',
      cpf: map['cpf']?.toString() ?? '',
      endereco: map['endereco']?.toString() ?? '',
      dataNascimento: map['dataNascimento']?.toString() ?? '',
      cargo: map['cargo']?.toString() ?? '',
    );
  }

  Map toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'cpf': cpf,
      'endereco': endereco,
      'dataNascimento': dataNascimento,
      'cargo': cargo,
    };
  }
}


List<Tarefa> listaTarefas = [
  Tarefa.fromMap({
    "id": 101,
    "nome": "Implementar Feature X",
    "descTarefa": "Desenvolver o módulo de relatórios financeiros.",
    "funcionario": 1, 
    "nivelTarefa": 1,
    "tipoTarefa": "Desenvolvimento",
    "periodicidade": "Mensal",
    "perioAvaliacao": "Quinzenal",
    "caminhoTarefa": "/dev/reports",
    "dataTarefaCriada": "2025-11-20T10:00:00Z",
    "dataVencimentoTarefa": "2025-12-31T23:59:59Z",
  }),
  Tarefa.fromMap({
    "id": 102,
    "nome": "Revisar Documentação",
    "descTarefa": "Atualizar manuais de procedimento após deploy.",
    "funcionario": 2, 
    "nivelTarefa": 2,
    "tipoTarefa": "Documentação",
    "periodicidade": "Pontual",
    "perioAvaliacao": "Diário",
    "caminhoTarefa": "/docs/manuals",
    "dataTarefaCriada": "2025-11-25T08:00:00Z",
    "dataVencimentoTarefa": "2025-12-05T17:00:00Z",
  }),
];
