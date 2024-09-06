import 'package:flutter/material.dart';

class TelaDesaparecidosWidget extends StatelessWidget {
  const TelaDesaparecidosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Widget'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          'Hello, this is a simple widget!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}