import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/record.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController moneyController = TextEditingController();
  final List<String> categories = [
    '定期収入',
    '臨時収入',
    'その他',
  ];
  String selectedCategory = '定期収入';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('収入入力'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Center(
  child: SizedBox(
    width: 300, // ← 好きな横幅
    child: TextField(
      controller: moneyController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: '金額',
        border: OutlineInputBorder(),
      ),
    ),
  ),
),
            const SizedBox(height: 20),

            Center(
  child: SizedBox(
    width: 300, // ← 好きな横幅
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
),
            const SizedBox(height: 20),
            ElevatedButton(
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
                  type: 'income',
                  date: DateTime.now(),
                );
                final messenger = ScaffoldMessenger.of(context);
                final navigator = Navigator.of(context);

                await DatabaseHelper.instance.insertRecord(record);
                if (!mounted) return;

                messenger.showSnackBar(
                  const SnackBar(content: Text('収入を保存しました')),
                );

                navigator.pop();
              },
              child: const Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
