import 'package:flutter/material.dart';
import 'package:barricapp/features/cava/screens/cava_screen.dart';
import 'package:barricapp/features/profile/screens/profile_screen.dart';
import 'package:barricapp/features/cava/screens/form_screen.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    final List<Widget> screens = [
      CavaScreen(key: UniqueKey()), 
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'Mi Cava' : 'Mi Perfil'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0, 
        scrolledUnderElevation: 0,
        actions: _currentIndex == 0
            ? [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              ]
            : null,
      ),
      body: screens[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NuevaCataScreen(),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.wine_bar), label: 'Cava'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}