import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';


class TarefasFormPage extends StatefulWidget {
  TarefasFormPage({super.key, required this.listaTarefas});

  List<Tarefa> listaTarefas;

  @override
  State<TarefasFormPage> createState() => _TarefasFormPageState();
}

class _TarefasFormPageState extends State<TarefasFormPage> {
  final _formKey = GlobalKey<FormState>();

  String? _nome;
  String? _desc;
  Funcionario? _funcionario;
  int? _nivelTarefa;
  String? _tipoTarefa;
  String? _periodicidade;
  String? _perioAvaliacao;
  String? _caminhoTarefa;
  DateTime? _dataCriacao;
  DateTime? _dataVencimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Nova Tarefa")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Nome da Tarefa"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o nome da tarefa';
                    }
                    return null;
                  },
                  onSaved: (value) => _nome = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Descrição da Tarefa"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a descrição';
                    }
                    return null;
                  },
                  onSaved: (value) => _desc = value,
                ),
                const SizedBox(height: 20),

                DropdownButtonFormField<Funcionario>(
                  decoration: const InputDecoration(labelText: "Funcionário Responsável"),
                  items: funcionarios.map((f) {
                    return DropdownMenuItem(
                      value: f,
                      child: Text(f.nome),
                    );
                  }).toList(),
                  onChanged: (value) => _funcionario = value,
                  validator: (value) {
                    if (value == null) return 'Selecione um funcionário';
                    return null;
                  },
                  onSaved: (value) => _funcionario = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Nível da Tarefa (1 a 10)"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Informe o nível';
                    final n = int.tryParse(value);
                    if (n == null || n < 1 || n > 10) return 'Nível deve ser entre 1 e 10';
                    return null;
                  },
                  onSaved: (value) => _nivelTarefa = int.parse(value!),
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Tipo da Tarefa"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Informe o tipo';
                    return null;
                  },
                  onSaved: (value) => _tipoTarefa = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Periodicidade"),
                  onSaved: (value) => _periodicidade = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Periodicidade de Avaliação"),
                  onSaved: (value) => _perioAvaliacao = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Caminho do Arquivo"),
                  onSaved: (value) => _caminhoTarefa = value,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Data de Criação (YYYY-MM-DD)"),
                  validator: (value) {
                    if (value != null && value.isNotEmpty && DateTime.tryParse(value) == null) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                  onSaved: (value) => _dataCriacao = value != null && value.isNotEmpty ? DateTime.parse(value) : null,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Data de Vencimento (YYYY-MM-DD)"),
                  validator: (value) {
                    if (value != null && value.isNotEmpty && DateTime.tryParse(value) == null) {
                      return 'Formato inválido';
                    }
                    return null;
                  },
                  onSaved: (value) => _dataVencimento = value != null && value.isNotEmpty ? DateTime.parse(value) : null,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Tarefa novaTarefa = Tarefa(
                        id: widget.listaTarefas.length + 1,
                        nome: _nome!,
                        descTarefa: _desc!,
                        funcionario: _funcionario!,
                        nivelTarefa: _nivelTarefa ?? 1,
                        tipoTarefa: _tipoTarefa ?? '',
                        periodicidade: _periodicidade ?? '',
                        perioAvaliacao: _perioAvaliacao ?? '',
                        caminhoTarefa: _caminhoTarefa ?? '',
                        dataTarefaCriada: _dataCriacao,
                        dataVencimentoTarefa: _dataVencimento,
                      );
                      
                        widget.listaTarefas.add(novaTarefa);
                      
                      debugPrint('RASTREIO 1: Formulario SALVOU. Total Tarefas: ${listaTarefas.length}');

                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Salvar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
