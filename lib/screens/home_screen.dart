import 'package:flutter/material.dart';
import '../models/task.dart'; // Importamos tu modelo de datos

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tareas de prueba para visualizar el diseño inicial
  final List<Task> _tasks = [
    Task(
      id: '1',
      title: 'Planificar estructura de la base de datos',
      description: 'Definir si usaremos SQLite, Hive o Isar para guardar localmente.',
      tags: ['Desarrollo', 'Importante'],
      isFlagged: true,
    ),
    Task(
      id: '2',
      title: 'Comprar materiales de ferretería',
      description: 'Lija, barniz de poliuretano y cinta métrica.',
      tags: ['Personal', 'Hogar'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Retornamos solo la lista, el Scaffold principal (con AppBar y menú) ya está en main.dart
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        final task = _tasks[index];
        return Card(
          elevation: 0,
          color: Colors.grey.shade50,
          margin: const EdgeInsets.only(bottom: 12.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            // El checkbox redondo estilo app de productividad
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value) {
                setState(() {
                  task.isCompleted = value ?? false;
                });
              },
              shape: const CircleBorder(),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              task.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                color: task.isCompleted ? Colors.grey : Colors.black87,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (task.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: task.isCompleted ? Colors.grey.shade400 : Colors.grey.shade700,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                // Fila para mostrar la bandera de prioridad y las etiquetas
                Row(
                  children: [
                    if (task.isFlagged) ...[
                      const Icon(Icons.flag, color: Colors.redAccent, size: 18),
                      const SizedBox(width: 8),
                    ],
                    // Generamos un "Chip" visual por cada etiqueta que tenga la tarea
                    ...task.tags.map((tag) => Padding(
                      padding: const EdgeInsets.only(right: 6.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ],
            ),
            trailing: const Icon(Icons.more_vert, color: Colors.grey),
            onTap: () {
              // Aquí en el futuro abriremos la pantalla de edición/detalles
            },
          ),
        );
      },
    );
  }
}