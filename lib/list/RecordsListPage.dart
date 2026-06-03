//SQLiteからデータを取得してリスト表示するページ
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/record.dart';

class RecordsListPage extends StatefulWidget {
  const RecordsListPage({super.key});

  @override
  State<RecordsListPage> createState() => _RecordsListPageState();
}

class _RecordsListPageState extends State<RecordsListPage> {
  Future<List<Record>> _loadRecords() async//非同期処理（DBアクセスは時間がかかるので使用）
   {
    return await DatabaseHelper.instance.getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('記録一覧'),
        backgroundColor: Colors.purple,
      ),
      //DB取得完了を待つWidget
      body: FutureBuilder<List<Record>>(
        future: _loadRecords(),//DBからデータ取得開始
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) //エラー発生時(DB取得失敗など)
          {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }

          final records = snapshot.data ?? [];
          //データが空のとき

          if (records.isEmpty) {
            return const Center(
              child: Text('記録がありません'),
            );
          }

          return ListView.separated(//一覧表示
            padding: const EdgeInsets.all(16),
            itemCount: records.length,
            //表示件数  =5なら5件表示
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final record = records[index];
              final isIncome = record.type == 'income';

              return Card(
                elevation: 2,
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isIncome ? Colors.blue : Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    '¥${record.amount}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        record.category,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${record.date.year}/${record.date.month.toString().padLeft(2, '0')}/${record.date.day.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isIncome ? Colors.blue[100] : Colors.red[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isIncome ? '収入' : '出費',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isIncome ? Colors.blue : Colors.red,
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
