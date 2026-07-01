import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/record.dart';
import 'ChartPage.dart';
import 'RecordsListPage.dart';

class MainContent extends StatefulWidget {
  final VoidCallback onExpense;
  final VoidCallback onIncome;

  const MainContent({
    required this.onExpense,
    required this.onIncome,
    super.key,
  });

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  Future<List<Record>> _loadRecords() async {
    return await DatabaseHelper.instance.getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // 統計情報カード
          FutureBuilder<List<Record>>(
            future: _loadRecords(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.active) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      height: 120,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'データの読み込みに失敗しました：${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                );
              }

              final records = snapshot.data ?? [];
              
              // 本日のデータのみをフィルタリング
              final today = DateTime.now();
              final todayRecords = records.where((r) {
                return r.date.year == today.year &&
                    r.date.month == today.month &&
                    r.date.day == today.day;
              }).toList();

              final todayExpense = todayRecords
                  .where((r) => r.type == 'expense')
                  .fold<int>(0, (sum, r) => sum + r.amount);
              final todayIncome = todayRecords
                  .where((r) => r.type == 'income')
                  .fold<int>(0, (sum, r) => sum + r.amount);
              final todayNet = todayIncome - todayExpense;

              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.blue[50]!, Colors.purple[50]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '本日の収支',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Text(
                                '収入',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '¥$todayIncome',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '支出',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '¥$todayExpense',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                '差引',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '¥$todayNet',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: todayNet >= 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          // 出費・収入ボタン
          Center(
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: widget.onExpense,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.red),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: const Text('出費'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: widget.onIncome,
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      child: const Text('収入'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // 情報確認ボタン
          Center(
            child: SizedBox(
              width: 300,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChartPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.pie_chart),
                      label: const Text('合計・グラフを見る'),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.purple),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecordsListPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.list),
                      label: const Text('詳細な記録を見る'),
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.teal),
                        foregroundColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        textStyle: WidgetStateProperty.all<TextStyle>(
                          const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}