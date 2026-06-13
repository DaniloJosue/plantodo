import 'package:flutter/material.dart';

void main() {
  runApp(const PlanTodoApp());
}

class PlanTodoApp extends StatelessWidget {
  const PlanTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlanTodo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista de tareas de prueba
  final List<String> _tasks = [
    'Configurar entorno Flutter',
    'Limpiar código base',
    'Diseñar la lista de tareas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlanTodo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Aquí usamos LayoutBuilder para elegir la interfaz según el ancho
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            // Si la pantalla es grande (Windows / Tablet horizontal)
            return _construirInterfazEscritorio();
          } else {
            // Si la pantalla es pequeña (Android / Móvil)
            return _construirInterfazMovil();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para agregar tarea
        },
        tooltip: 'Agregar tarea',
        child: const Icon(Icons.add),
      ),
    );
  }

  // INTERFAZ PARA MÓVIL: Una columna simple con la lista
  Widget _construirInterfazMovil() {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.radio_button_unchecked, color: Colors.teal),
            title: Text(_tasks[index]),
          ),
        );
      },
    );
  }

  // INTERFAZ PARA ESCRITORIO: Dos columnas (Panel lateral + Lista)
  Widget _construirInterfazEscritorio() {
    return Row(
      children: [
        // Panel lateral izquierdo (Menú o categorías)
        NavigationRail(
          selectedIndex: 0,
          labelType: NavigationRailLabelType.all,
          destinations: const [
            NavigationRailDestination(icon: Icon(Icons.wb_sunny), label: Text('Mi Día')),
            NavigationRailDestination(icon: Icon(Icons.calendar_month), label: Text('Calendario')),
          ],
          onDestinationSelected: (index) {},
        ),
        const VerticalDivider(thickness: 1, width: 1),
        // Espacio principal para la lista de tareas
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _construirInterfazMovil(), // Reutilizamos la lista aquí
          ),
        ),
      ],
    );
  }
}