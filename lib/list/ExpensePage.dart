import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
//ここに実際の画面処理（UI、ボタン処理、入力値を書く

/*TextFieldの入力値を管理する
入力されたら、moneyControllerで取得
*/

  final TextEditingController moneyController =
      TextEditingController();
    

  @override
  //画面をどう表示するかを書く
  Widget build(BuildContext context) {
    //↓アプリ画面の土台みたいなもの
    return Scaffold(
      //↓画面上のタイトル部分（出費入力）
      appBar: AppBar(
        title: const Text('出費入力'),
      ),
      
      //余白
      body: Padding(
        padding: const EdgeInsets.all(16),
        
        /*横に並べるWidget
        TextField
        ↓
        余白
        ↓
        ボタン
        */
        child: Column(
          children: [
            //入力欄
            TextField(
              //TextFieldとControllerを接続、これで入力値を取得
              controller: moneyController,
              //数字キーボードにする
              keyboardType: TextInputType.number,

              decoration: const InputDecoration(
                labelText: "金額",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
              //ボタンを押したときの処理

                print(moneyController.text);
                /*入力された値をコンソールに表示
                今後は
                入力
                ↓
                Listに保存
                ↓
                ListView表示
                ↓
                グラフ
                */

                

              },

              child: const Text("登録"),
            ),
          ],
        ),
      ),
    );
  }
}