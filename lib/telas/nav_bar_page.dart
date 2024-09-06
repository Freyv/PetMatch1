import 'package:flutter/material.dart';
import 'package:petmatch/telas/tela_inicial.dart'; // Adjust paths according to your project structure
import 'package:petmatch/telas/tela_denuncias.dart';
import 'package:petmatch/telas/tela_desaparecidos.dart';

class NavBarPage extends StatefulWidget {
  final String initialPage;

  const NavBarPage({super.key, this.initialPage = 'home'});

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TelaInicialWidget(),
    const TelaDenunciasWidget(),
    const TelaDesaparecidosWidget(),
  ];

  @override
  void initState() {
    super.initState();
    // Set initial page based on the argument
    if (widget.initialPage == 'home') {
      _currentIndex = 0;
    } else if (widget.initialPage == 'profile') {
      _currentIndex = 1;
    } else if (widget.initialPage == 'settings') {
      _currentIndex = 2;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}