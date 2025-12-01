import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/main.dart';
import 'package:tarefas/tarefasFormPage.dart';


class TarefasPage extends StatefulWidget {
  final String title;

  final VoidCallback? onTaskAdded;

  const TarefasPage({super.key, required this.title, this.onTaskAdded});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
          child: ListView.builder(
            itemCount:
                listaTarefas.length, // Usando a lista global do main.dart
            itemBuilder: (BuildContext context, int index) {
              final tarefa = listaTarefas[index];

              final dataVencimentoFormatada =
                  tarefa.dataVencimentoTarefa != null
                  ? '${tarefa.dataVencimentoTarefa!.day}/${tarefa.dataVencimentoTarefa!.month}/${tarefa.dataVencimentoTarefa!.year}'
                  : 'N/A';
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ExpansionTile(
                  leading: Icon(
                    tarefa.nivelTarefa == 1
                        ? Icons.star
                        : tarefa.nivelTarefa == 2
                        ? Icons.star_half
                        : Icons.star_border,
                    color: Colors.blue,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          tarefa.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Vencimento: $dataVencimentoFormatada',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Descrição: ${tarefa.descTarefa}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Funcionário Responsável: ${tarefa.funcionario.nome}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Nivel da Tarefa: ${tarefa.nivelTarefa}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Tipo da Tarefa: ${tarefa.tipoTarefa}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Periodicidade: ${tarefa.periodicidade}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Avaliação Periodica: ${tarefa.perioAvaliacao}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Caminho do Arquivo da Tarefa: ${tarefa.caminhoTarefa}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Data de Criação da Tarefa: ${tarefa.dataTarefaCriada != null ? '${tarefa.dataTarefaCriada!.day}/${tarefa.dataTarefaCriada!.month}/${tarefa.dataTarefaCriada!.year}' : 'N/A'}',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Data de Vencimento da Tarefa: $dataVencimentoFormatada',
                            style: const TextStyle(fontStyle: FontStyle.normal),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TarefasFormPage(listaTarefas: listaTarefas),
            ),
          );
          debugPrint('RASTREIO 2: TarefasPage (Lista Gestão) atualizada. Total Tarefas: ${listaTarefas.length}');
          setState(() {
            // Atualizar a lista de tarefas após o retorno do formulário
          });
          widget.onTaskAdded?.call();
        },
        tooltip: 'Adicionar Nova Tarefa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
