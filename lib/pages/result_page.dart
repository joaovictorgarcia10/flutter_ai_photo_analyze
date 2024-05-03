import 'dart:io';

import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String analysis;
  final String image;

  const ResultPage({
    super.key,
    required this.analysis,
    required this.image,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(widget.image)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            Text(
              widget.analysis,
              style: const TextStyle(fontSize: 14.0),
            ),
          ],
        )),
      ),
    );
  }
}
