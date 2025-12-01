import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';

class FuncionariosFormPage extends StatefulWidget {
  const FuncionariosFormPage({super.key});

  @override
  State<FuncionariosFormPage> createState() => _FuncionariosFormPageState();
}

class _FuncionariosFormPageState extends State<FuncionariosFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cpfController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cargoController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  // Função para abrir o calendário e formatar a data para String
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), 
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
  
        _dataNascimentoController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _salvarFuncionario() {
    if (_formKey.currentState!.validate()) {

      final newId = funcionarios.isEmpty ? 1 : funcionarios.last.id + 1;

      final novoFuncionario = Funcionario(
        id: newId,
        nome: _nomeController.text,
        email: _emailController.text,
        telefone: _telefoneController.text,
        cpf: _cpfController.text,
        endereco: _enderecoController.text,
        dataNascimento: _dataNascimentoController.text,
        cargo: _cargoController.text,
      );

      setState(() {
        funcionarios.add(novoFuncionario);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Funcionário "${novoFuncionario.nome}" salvo!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    _enderecoController.dispose();
    _cargoController.dispose();
    _dataNascimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Funcionário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(
                  controller: _nomeController,
                  label: 'Nome Completo',
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _cargoController,
                  label: 'Cargo',
                  icon: Icons.work,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _telefoneController,
                  label: 'Telefone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _cpfController,
                  label: 'CPF',
                  icon: Icons.badge,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _enderecoController,
                  label: 'Endereço',
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _dataNascimentoController,
                  readOnly: true, 
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento',
                    prefixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () => _selecionarData(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a data de nascimento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _salvarFuncionario,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Funcionário'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para criar campos de texto padrão
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo obrigatório';
        }
        return null;
      },
    );
  }
}