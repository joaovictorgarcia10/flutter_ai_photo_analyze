// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_ai_photo_analyze/widgets/button/button_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Escolha o formato que deseja enviar a sua redação:",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              ButtonComponent(
                title: "Enviar via Imagem",
                onTap: () => Navigator.pushNamed(context, '/image'),
              ),
              const SizedBox(height: 20.0),
              ButtonComponent(
                title: "Enviar via PDF",
                onTap: () => Navigator.pushNamed(context, '/pdf'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
