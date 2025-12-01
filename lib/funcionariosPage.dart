import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/funcionariosFormPage.dart'; 

class FuncionariosPage extends StatefulWidget {
  const FuncionariosPage({super.key});

  @override
  State<FuncionariosPage> createState() => _FuncionariosPageState();
}

class _FuncionariosPageState extends State<FuncionariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: funcionarios.isEmpty
          ? const Center(
              child: Text(
                'Nenhum funcionário cadastrado.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: funcionarios.length,
              itemBuilder: (BuildContext context, int index) {
                final funcionario = funcionarios[index];

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 2,
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        funcionario.id.toString(),
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      funcionario.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      funcionario.cargo,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                Icons.email, 'Email', funcionario.email),
                            const Divider(),
                            _buildInfoRow(
                                Icons.phone, 'Telefone', funcionario.telefone),
                            const Divider(),
                            _buildInfoRow(Icons.badge, 'CPF', funcionario.cpf),
                            const Divider(),
                            _buildInfoRow(Icons.location_on, 'Endereço',
                                funcionario.endereco),
                            const Divider(),
                            _buildInfoRow(Icons.cake, 'Data de Nascimento',
                                funcionario.dataNascimento),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FuncionariosFormPage(),
            ),
          );

          setState(() {});
        },
        tooltip: 'Adicionar Funcionário',
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: value),
              ],
            ),
          ),
        ),
      ],
    );
  }
}