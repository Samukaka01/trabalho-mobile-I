import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simula o usuário logado (Pegamos o primeiro da lista ou um ID fixo)
    final usuarioLogado = funcionarios.isNotEmpty
        ? funcionarios.firstWhere(
            (f) => f.id == 1,
            orElse: () => funcionarios[0],
          )
        : null;

    if (usuarioLogado == null) {
      return const Center(child: Text("Nenhum perfil encontrado."));
    }

    // Calcula estatísticas básicas para exibir no perfil
    final tarefasDoUsuario = listaTarefas
        .where((t) => t.funcionario.id == usuarioLogado.id)
        .toList();
    final totalTarefas = tarefasDoUsuario.length;
    final tarefasAltaPrioridade = tarefasDoUsuario
        .where((t) => t.nivelTarefa == 1)
        .length;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Foto e Nome
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      usuarioLogado.nome[0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    usuarioLogado.nome,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    usuarioLogado.cargo,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileItem(
                      Icons.email,
                      'E-mail',
                      usuarioLogado.email,
                    ),
                    const Divider(),
                    _buildProfileItem(
                      Icons.phone,
                      'Telefone',
                      usuarioLogado.telefone,
                    ),
                    const Divider(),
                    _buildProfileItem(
                      Icons.location_on,
                      'Endereço',
                      usuarioLogado.endereco,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // Botão de Logout (Visual)
            TextButton.icon(
              onPressed: () {
                // Lógica de logout futura
              },
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text(
                'Sair da Conta',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
