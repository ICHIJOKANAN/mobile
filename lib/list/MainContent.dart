import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: Text(
                "家計簿アプリ",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // 出費・収入ボタン
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: widget.onExpense,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    minimumSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: const Text('出費'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: widget.onIncome,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    minimumSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  child: const Text('収入'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 情報確認ボタン
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
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
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    minimumSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
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
                    backgroundColor: WidgetStateProperty.all<Color>(Colors.teal),
                    foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                    minimumSize: WidgetStateProperty.all<Size>(const Size(200, 60)),
                    textStyle: WidgetStateProperty.all<TextStyle>(
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 