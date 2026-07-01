import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/record.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final TextEditingController moneyController = TextEditingController();
  final List<String> categories = [
    '食費',
    '生活費',
    '交通費',
    '娯楽費',
    '固定費',
  ];
  String selectedCategory = '食費';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('出費入力'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: moneyController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '金額',
                      hintText: '例: 1200',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: DropdownButtonFormField<String>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'カテゴリ',
                      border: OutlineInputBorder(),
                    ),
                    items: categories
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () async {
                      final amount = int.tryParse(moneyController.text);
                      if (amount == null || amount <= 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('正しい金額を入力してください')),
                        );
                        return;
                      }

                      final record = Record(
                        amount: amount,
                        category: selectedCategory,
                        type: 'expense',
                        date: DateTime.now(),
                      );
                      final navigator = Navigator.of(context);

                      await DatabaseHelper.instance.insertRecord(record);
                      if (!mounted) return;

                      navigator.pop('expense_saved');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('登録'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}