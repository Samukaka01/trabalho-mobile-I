import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';

class TarefasFormPage extends StatefulWidget {
  final List<Tarefa> listaTarefas;

  const TarefasFormPage({super.key, required this.listaTarefas});

  @override
  State<TarefasFormPage> createState() => _TarefasFormPageState();
}

class _TarefasFormPageState extends State<TarefasFormPage> {
  final _formKey = GlobalKey<FormState>();


  final _nomeController = TextEditingController();
  final _descController = TextEditingController();
  final _nivelController = TextEditingController();
  final _tipoController = TextEditingController();
  final _periodicidadeController = TextEditingController();
  final _avaliacaoController = TextEditingController();
  final _caminhoController = TextEditingController();
  final _dataCriacaoController = TextEditingController();
  final _dataVencimentoController = TextEditingController();


  Funcionario? _funcionarioSelecionado;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _dataCriacaoController.text = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
  }

  Future<void> _selecionarData(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _salvarTarefa() {
    if (_formKey.currentState!.validate()) {
      if (_funcionarioSelecionado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione um funcionário responsável.')),
        );
        return;
      }
      final newId = widget.listaTarefas.isEmpty ? 1 : widget.listaTarefas.last.id + 1;

 
      final novaTarefa = Tarefa(
        id: newId,
        nome: _nomeController.text,
        descTarefa: _descController.text,
        funcionario: _funcionarioSelecionado!,
        nivelTarefa: int.tryParse(_nivelController.text) ?? 1,
        tipoTarefa: _tipoController.text,
        periodicidade: _periodicidadeController.text,
        perioAvaliacao: _avaliacaoController.text,
        caminhoTarefa: _caminhoController.text,
        dataTarefaCriada: DateTime.tryParse(_dataCriacaoController.text),
        dataVencimentoTarefa: DateTime.tryParse(_dataVencimentoController.text),
      );

      widget.listaTarefas.add(novaTarefa);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tarefa "${novaTarefa.nome}" salva com sucesso!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _descController.dispose();
    _nivelController.dispose();
    _tipoController.dispose();
    _periodicidadeController.dispose();
    _avaliacaoController.dispose();
    _caminhoController.dispose();
    _dataCriacaoController.dispose();
    _dataVencimentoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Nova Tarefa"),
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
                  label: 'Nome da Tarefa',
                  icon: Icons.task,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _descController,
                  label: 'Descrição',
                  icon: Icons.description,
                ),
                const SizedBox(height: 15),

                DropdownButtonFormField<Funcionario>(
                  decoration: const InputDecoration(
                    labelText: "Funcionário Responsável",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  value: _funcionarioSelecionado,
                  items: funcionarios.map((f) {
                    return DropdownMenuItem(
                      value: f,
                      child: Text(f.nome),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _funcionarioSelecionado = value;
                    });
                  },
                  validator: (value) => value == null ? 'Selecione um funcionário' : null,
                ),
                const SizedBox(height: 15),

                _buildTextField(
                  controller: _nivelController,
                  label: 'Nível da Tarefa (1 a 10)',
                  icon: Icons.bar_chart,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _tipoController,
                  label: 'Tipo da Tarefa',
                  icon: Icons.category,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _periodicidadeController,
                  label: 'Periodicidade',
                  icon: Icons.repeat,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _avaliacaoController,
                  label: 'Período de Avaliação',
                  icon: Icons.rule,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _caminhoController,
                  label: 'Caminho do Arquivo',
                  icon: Icons.folder,
                ),
                const SizedBox(height: 15),

                _buildDatePicker(
                  controller: _dataCriacaoController,
                  label: 'Data de Criação',
                  icon: Icons.calendar_today,
                ),
                const SizedBox(height: 15),
                _buildDatePicker(
                  controller: _dataVencimentoController,
                  label: 'Data de Vencimento',
                  icon: Icons.event_busy,
                ),

                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _salvarTarefa,
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar Tarefa'),
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

  // Widget auxiliar para criar campos de Data
  Widget _buildDatePicker({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true, 
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      onTap: () => _selecionarData(context, controller),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe a data';
        }
        return null;
      },
    );
  }
}