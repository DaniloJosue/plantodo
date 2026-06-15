import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // <--- Agrega esta línea

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Color base, puedes cambiarlo
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}

// Este es el esqueleto o "Layout" principal que controla la navegación
class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  // Lista de las pantallas centrales
  final List<Widget> _screens = [
    const HomeScreen(), // <--- Tu nueva pantalla de inicio
    const Center(child: Text('Pantalla de Calendario')),
    const Center(child: Text('Vistas (Lista, Tablero, Árbol)')),
    const Center(child: Text('Pantalla de Hábitos')),
    const Center(child: Text('Otras Herramientas')),
    const Center(child: Text('Proyectos')),
  ];

  // Títulos para la barra superior según la pantalla
  final List<String> _titles = [
    'Inicio',
    'Calendario',
    'Vistas',
    'Hábitos',
    'Herramientas',
    'Proyectos'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. BARRA SUPERIOR
      appBar: AppBar(
        title: Text(_titles[_currentIndex], style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        // Flutter agrega automáticamente el botón de menú izquierdo (leading) cuando usas 'drawer'
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // El funcionamiento de este botón lo haremos después
            },
          ),
        ],
      ),
      
      // 2. MENÚ LATERAL IZQUIERDO (Cambiamos 'endDrawer' por 'drawer')
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Usuario PlanTodo'),
              accountEmail: Text('Perfil de usuario'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Gestión de Proyectos'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.label),
              title: const Text('Etiquetas'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Listas de Tareas'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.collections_bookmark),
              title: const Text('Colecciones'),
              onTap: () {},
            ),
          ],
        ),
      ),

      // 3. CONTENIDO CENTRAL 
      body: _screens[_currentIndex],

      // 4. MENÚ INFERIOR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Calendario'),
          BottomNavigationBarItem(icon: Icon(Icons.view_carousel), label: 'Vistas'),
          BottomNavigationBarItem(icon: Icon(Icons.track_changes), label: 'Hábitos'),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Extras'),
          BottomNavigationBarItem(icon: Icon(Icons.folder_copy), label: 'Proyectos'),
        ],
      ),
    );
  }
}