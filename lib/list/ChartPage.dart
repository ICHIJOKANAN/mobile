import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../db/database_helper.dart';
//SQLiteからデータ取得
import '../models/record.dart';
//Recodeクラスを利用

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  Future<List<Record>> _loadRecords() async {
    return await DatabaseHelper.instance.getRecords();
  }//SQLiteから全データ取得

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('収支グラフ'),
      ),
      body: FutureBuilder<List<Record>>(
        future: _loadRecords(),//Dからデータ取得開始
        builder: (context, snapshot) //取得状況を監視
        {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) //エラー発生時(DB取得失敗など)
          {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }
          final records = snapshot.data ?? [];//データ取得成功、recordsにデータ格納
          if (records.isEmpty)  //データが空のとき
          {
            return const Center(child: Text('データがありません'));
          }

          //収入と出費の合計を計算
          final expenseTotal = records
              .where((record) => record.type == 'expense') //出費のみ抽出
              .fold<int>(0, (sum, record) => sum + record.amount);//合計計算
          final incomeTotal = records
              .where((record) => record.type == 'income')
              .fold<int>(0, (sum, record) => sum + record.amount);
          final netTotal = incomeTotal - expenseTotal;//差引計算

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('合計', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        Text('収入: ¥$incomeTotal', style: const TextStyle(fontSize: 16, color: Colors.blue)),
                        const SizedBox(height: 8),
                        Text('出費: ¥$expenseTotal', style: const TextStyle(fontSize: 16, color: Colors.red)),
                        const SizedBox(height: 8),
                        Text('差引: ¥$netTotal', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('収支割合', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: PieChart(//円グラフ表示
                            PieChartData(
                              sectionsSpace: 4,
                              centerSpaceRadius: 40,
                              sections: [
                                if (incomeTotal > 0)
                                  PieChartSectionData(
                                    value: incomeTotal.toDouble(),
                                    title: '収入',
                                    color: Colors.blue,
                                    radius: 80,
                                    titleStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                if (expenseTotal > 0)
                                  PieChartSectionData(//出費の割合表示
                                    value: expenseTotal.toDouble(),//出費の割合表示
                                    title: '出費',
                                    color: Colors.red,
                                    radius: 80,
                                    titleStyle: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'データ件数: ${records.length}',
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
