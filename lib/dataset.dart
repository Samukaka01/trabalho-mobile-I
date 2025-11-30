import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Tarefa {
  final int id;
  String nome;
  String descTarefa;
  String funcionario; // aqui tem que ser uma referencia a classe do funcionario
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
    return Tarefa(
      id: map['id'] is int
          ? map['id'] as int
          : int.tryParse('${map['id']}') ?? 0,
      nome: map['nome']?.toString() ?? '',
      descTarefa: map['descTarefa']?.toString() ?? '',
      funcionario: map['funcionario']?.toString() ?? '',
      nivelTarefa: map['nivelTarefa'] is int
          ? map['nivelTarefa'] as int
          : int.tryParse('${map['nivelTarefa']}') ?? 0,
      tipoTarefa: map['tipoTarefa']?.toString() ?? '',
      periodicidade: map['periodicidade']?.toString() ?? '',
      perioAvaliacao: map['perioAvaliacao']?.toString() ?? '',
      caminhoTarefa: map['caminhoTarefa']?.toString() ?? '',
      dataTarefaCriada: map['dataTarefaCriada'] != null
          ? DateTime.tryParse(map['dataTarefaCriada'].toString())
          : null,
      dataVencimentoTarefa: map['dataVencimentoTarefa'] != null
          ? DateTime.tryParse(map['dataVencimentoTarefa'].toString())
          : null,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'nome': nome,
      'descTarefa': descTarefa,
      'funcionario': funcionario,
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
      Tarefa.fromMap(json.decode(source) as Map);
  String toJson() => json.encode(toMap());

  Tarefa copyWith({
    int? id,
    String? nome,
    String? descTarefa,
    String? funcionario,
    int? nivelTarefa,
    String? tipoTarefa,
    String? periodicidade,
    String? perioAvaliacao,
    String? caminhoTarefa,
    DateTime? dataTarefaCriada,
    DateTime? dataVencimentoTarefa,
  }) {
    return Tarefa(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      descTarefa: descTarefa ?? this.descTarefa,
      funcionario: funcionario ?? this.funcionario,
      nivelTarefa: nivelTarefa ?? this.nivelTarefa,
      tipoTarefa: tipoTarefa ?? this.tipoTarefa,
      periodicidade: periodicidade ?? this.periodicidade,
      perioAvaliacao: perioAvaliacao ?? this.perioAvaliacao,
      caminhoTarefa: caminhoTarefa ?? this.caminhoTarefa,
      dataTarefaCriada: dataTarefaCriada ?? this.dataTarefaCriada,
      dataVencimentoTarefa: dataVencimentoTarefa ?? this.dataVencimentoTarefa,
    );
  }

  @override
  String toString() {
    return 'Tarefa(id: $id, nome: $nome, descTarefa: $descTarefa, funcionario: $funcionario, nivelTarefa: $nivelTarefa, tipoTarefa: $tipoTarefa, periodicidade: $periodicidade, perioAvaliacao: $perioAvaliacao, caminhoTarefa: $caminhoTarefa, dataTarefaCriada: $dataTarefaCriada, dataVencimentoTarefa: $dataVencimentoTarefa)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Tarefa &&
            other.id == id &&
            other.nome == nome &&
            other.descTarefa == descTarefa &&
            other.funcionario == funcionario &&
            other.nivelTarefa == nivelTarefa &&
            other.tipoTarefa == tipoTarefa &&
            other.periodicidade == periodicidade &&
            other.perioAvaliacao == perioAvaliacao &&
            other.caminhoTarefa == caminhoTarefa &&
            other.dataTarefaCriada == dataTarefaCriada &&
            other.dataVencimentoTarefa == dataVencimentoTarefa);
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    descTarefa,
    funcionario,
    nivelTarefa,
    tipoTarefa,
    periodicidade,
    perioAvaliacao,
    caminhoTarefa,
    dataTarefaCriada,
    dataVencimentoTarefa,
  );
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
      id: map['id'] is int
          ? map['id'] as int
          : int.tryParse('${map['id']}') ?? 0,
      nome: map['nome']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      telefone: map['telefone']?.toString() ?? '',
      cpf: map['cpf']?.toString() ?? '',
      endereco: map['endereco']?.toString() ?? '',
      dataNascimento: map['dataNascimento']?.toString() ?? '', // depois tentar colocar um type date
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

  factory Funcionario.fromJson(String source) =>
      Funcionario.fromMap(json.decode(source) as Map);
  String toJson() => json.encode(toMap());

  Funcionario copyWith({
    int? id,
    String? nome,
    String? email,
    String? telefone,
    String? cpf,
    String? endereco,
    String? dataNascimento,
    String? cargo,
  }) {
    return Funcionario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      cpf: cpf ?? this.cpf,
      endereco: endereco ?? this.endereco,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      cargo: cargo ?? this.cargo,
    );
  }

  @override
  String toString() {
    return 'Funcionario(id: $id, nome: $nome, email: $email, telefone: $telefone, cpf: $cpf, endereco: $endereco, dataNascimento: $dataNascimento, cargo: $cargo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Funcionario &&
            other.id == id &&
            other.nome == nome &&
            other.email == email &&
            other.telefone == telefone &&
            other.cpf == cpf &&
            other.endereco == endereco &&
            other.dataNascimento == dataNascimento &&
            other.cargo == cargo);
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    email,
    telefone,
    cpf,
    endereco,
    dataNascimento,
    cargo,
  );
}

List minhasTarefas = [];


List<Tarefa> tarefas = [
  Tarefa.fromMap({
    "id": 101,
    "nome": "Implementar Feature X",
    "descTarefa": "Desenvolver o módulo de relatórios financeiros.",
    "funcionario": "Alice Silva",
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
    "funcionario": "Bruno Costa",
    "nivelTarefa": 2,
    "tipoTarefa": "Documentação",
    "periodicidade": "Pontual",
    "perioAvaliacao": "Diário",
    "caminhoTarefa": "/docs/manuals",
    "dataTarefaCriada": "2025-11-25T08:00:00Z",
    "dataVencimentoTarefa": "2025-12-05T17:00:00Z",
  }),
];