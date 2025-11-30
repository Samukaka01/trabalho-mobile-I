import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tarefas/dataset.dart';
import 'package:tarefas/main.dart';

class MinhasTarefasPage extends StatelessWidget {
  final String title;
  const MinhasTarefasPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(title)));
}