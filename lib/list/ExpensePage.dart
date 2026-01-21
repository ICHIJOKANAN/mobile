import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('出費入力'),
      ),
      body: const Center(
        child: Text(
          'ここに出費入力画面を作る',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
