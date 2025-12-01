import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/tarefasPage.dart';
import 'package:tarefas/funcionariosPage.dart';
import 'package:tarefas/perfilPage.dart'; // ✅ Importamos a nova página de Perfil

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
// WIDGET: MainScreen (Gerencia a navegação)
// =================================================================

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // ✅ Lista de Títulos atualizada (sem Minhas Tarefas, com Perfil no fim)
  final List<String> _titles = <String>[
    'Dashboard',
    'Gestão de Tarefas',
    'Funcionários',
    'Meu Perfil',
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

    // ✅ Lista de Widgets reorganizada
    final List<Widget> _widgetOptions = <Widget>[
      // 1. Dashboard (Home)
      HomePageTarefas(title: 'Dashboard'),
      
      // 2. Gestão de Tarefas (Antigo item 3, agora é o 2)
      TarefasPage(title: 'Gestão de Tarefas', onTaskAdded: recarregarInfos),
      
      // 3. Funcionários (Antigo item 4, agora é o 3)
      const FuncionariosPage(),

      // 4. Perfil (Novo item, no final)
      const PerfilPage(), 
    ];

    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: Center(
        child: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed, // Garante que os 4 itens apareçam bem
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: 'Gestão',
            icon: Icon(Icons.add_task),
            activeIcon: Icon(Icons.task),
          ),
          BottomNavigationBarItem(
            label: 'Equipe',
            icon: Icon(Icons.people_alt_outlined),
            activeIcon: Icon(Icons.people_alt),
          ),
          // ✅ Novo Item: Perfil (Última posição)
          BottomNavigationBarItem(
            label: 'Perfil',
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}

// =================================================================
// HomePageTarefas (Mantido igual, apenas para visualização)
// =================================================================

class HomePageTarefas extends StatelessWidget {
  final String title;

  const HomePageTarefas({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // Ordena as tarefas
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Descrição: ${tarefa.descTarefa}'),
                        const SizedBox(height: 10),
                        Text('Funcionário Responsável: ${tarefa.funcionario.nome}'),
                        const SizedBox(height: 10),
                        Text('Nivel da Tarefa: ${tarefa.nivelTarefa}'),
                        const SizedBox(height: 10),
                        Text('Tipo da Tarefa: ${tarefa.tipoTarefa}'),
                        const SizedBox(height: 10),
                        Text('Periodicidade: ${tarefa.periodicidade}'),
                        const SizedBox(height: 10),
                        Text('Avaliação Periodica: ${tarefa.perioAvaliacao}'),
                        const SizedBox(height: 10),
                        Text('Caminho do Arquivo: ${tarefa.caminhoTarefa}'),
                        const SizedBox(height: 10),
                        Text('Data de Criação: ${tarefa.dataTarefaCriada != null ? '${tarefa.dataTarefaCriada!.day}/${tarefa.dataTarefaCriada!.month}/${tarefa.dataTarefaCriada!.year}' : 'N/A'}'),
                        const SizedBox(height: 10),
                        Text('Data de Vencimento: $dataVencimentoFormatada'),
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