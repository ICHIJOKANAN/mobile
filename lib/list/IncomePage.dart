import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('収入入力'),
      ),
      body: const Center(
        child: Text(
          'ここに収入入力画面を作る',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
