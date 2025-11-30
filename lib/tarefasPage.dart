import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/main.dart'; 
// Note: 'dart:developer' não é necessário neste arquivo

class TarefasPage extends StatefulWidget {
  final String title;

  const TarefasPage({super.key, required this.title});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  @override
  Widget build(BuildContext context) {
    // A tela inteira agora é apenas o corpo do Scaffold
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        child: ListView.builder(
          itemCount: tarefas.length, // Usando a lista global do main.dart
          itemBuilder: (BuildContext context, int index) {
            final tarefa = tarefas[index];

            final dataVencimentoFormatada = tarefa.dataVencimentoTarefa != null 
              ? '${tarefa.dataVencimentoTarefa!.day}/${tarefa.dataVencimentoTarefa!.month}/${tarefa.dataVencimentoTarefa!.year}' 
              : 'N/A';

            // 🛑 FIX: O retorno do Card é obrigatório para exibir o item.
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: ExpansionTile(
                // Ícone de Nível da Tarefa
                leading: Icon(
                    tarefa.nivelTarefa == 1
                        ? Icons.star
                        : tarefa.nivelTarefa == 2
                            ? Icons.star_half
                            : Icons.star_border,
                    color: Colors.blue),
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
                // Corpo com detalhes da Tarefa
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
                          // 🛑 FIX: Acessando a propriedade 'nome' do objeto Funcionario
                          'Funcionário Responsável: ${tarefa.funcionario}', 
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
                          'Data de Criação da Tarefa: ${tarefa.dataTarefaCriada != null ?
                            '${tarefa.dataTarefaCriada!.day}/${tarefa.dataTarefaCriada!.month}/${tarefa.dataTarefaCriada!.year}'
                            : 'N/A'}',
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
    );
    
  }
}