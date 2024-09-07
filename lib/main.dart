import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core for initialization
import 'package:get/get.dart'; // For GetX state management
import 'package:petmatch/firebase_options.dart';
import 'package:petmatch/services/auth_service.dart'; // Import AuthService
import 'package:petmatch/telas/tela_login.dart';
import 'package:petmatch/telas/tela_cadastro.dart';
import 'package:petmatch/telas/nav_bar_page.dart'; // Ensure this import is correct

// Entry point of the application
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize AuthService
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthWrapper(), // Use AuthWrapper to handle authentication
      routes: {
        '/login': (context) => const TelaLoginWidget(),
        '/signup': (context) => const TelaCadastroWidget(),
      },
    );
  }
}

// Wrapper widget to handle authentication
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Listen to the userIsAuthenticated observable from AuthService
      if (AuthService.to.userIsAuthenticated.value) {
        // User is authenticated, show TelaInicial
        return const TelaInicialWidget(); // Ensure this widget is set up to include NavBarPage
      } else {
        // User is not authenticated, show TelaLogin
        return const TelaLoginWidget();
      }
    });
  }
}

// Ensure TelaInicialWidget includes the NavBarPage if needed
class TelaInicialWidget extends StatelessWidget {
  const TelaInicialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: NavBarPage(initialPage: 'home'), // Use a string or correct identifier
    );
  }
}
