import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/minhasTarefas.dart';
import 'package:tarefas/tarefasPage.dart';
import 'package:tarefas/funcionariosPage.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Gestão de Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}

// =================================================================
// WIDGET: MainScreen (Gerencia a navegação com BottomNavigationBar)
// =================================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = <String>[
    'Dashboard de Tarefas',
    'Minhas Tarefas',
    'Gestão de Tarefas',
    'Funcionários',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    void recarregarInfos() {
      setState(() {});
    }

    final List<Widget> _widgetOptions = <Widget>[
      HomePageTarefas(title: 'Dashboard de Tarefas'), 
      MinhasTarefasPage(title: 'Minhas Tarefas'),
      TarefasPage(title: 'Gestão de Tarefas', onTaskAdded: recarregarInfos), 
      const FuncionariosPage(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions, // Usa a lista recriada no build
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: 'Minhas Tarefas',
            icon: Icon(Icons.assignment_turned_in_outlined),
            activeIcon: Icon(Icons.assignment_turned_in),
          ),
          BottomNavigationBarItem(
            label: 'Gestão de Tarefas',
            icon: Icon(Icons.add_task),
            activeIcon: Icon(Icons.task),
          ),
          BottomNavigationBarItem(
            label: 'Funcionários',
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people_alt),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// HomePageTarefas (APLICADO O ESTILO Card/ExpansionTile)
// =================================================================

class HomePageTarefas extends StatelessWidget {
  final String title;


  const HomePageTarefas({super.key, required this.title}); 

  @override
  Widget build(BuildContext context) {
    debugPrint('RASTREIO 3: HomePageTarefas (Dashboard) reconstruiu. Total Tarefas: ${listaTarefas.length}');
    

    final List<Tarefa> sortedTarefas = List<Tarefa>.from(listaTarefas);
    sortedTarefas.sort((a, b) {

      if (a.dataVencimentoTarefa == null) return 1;
      if (b.dataVencimentoTarefa == null) return -1;
      return a.dataVencimentoTarefa!.compareTo(b.dataVencimentoTarefa!);
    });

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
        child: ListView.builder(
          itemCount: sortedTarefas.length,
          itemBuilder: (BuildContext context, int index) {
            final tarefa = sortedTarefas[index];
            
            final dataVencimentoFormatada =
                '${tarefa.dataVencimentoTarefa!.day}/${tarefa.dataVencimentoTarefa!.month}/${tarefa.dataVencimentoTarefa!.year}';

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
    );
  }
}