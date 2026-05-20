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
  final List<String> categories = [
    '食費',
    '生活費',
    '交通費',
    '娯楽費',
    '固定費',
  ];
  String selectedCategory = '食費';

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


            //高さ20pxの余白を入れる
            const SizedBox(height: 20),


            //プルダウン形式の入力フォームを作成
            DropdownButtonFormField<String>(

              /*現在選択されている値
              selectedCategoryに入ってる値が表示される*/
              value: selectedCategory,

              //入力フォームの見た目の設定
              decoration: const InputDecoration(
                //フォームのラベル(タイトル)
                labelText: 'カテゴリ',
                //枠線
                border: OutlineInputBorder(),
              ),
              items: categories//プルダウンの選択肢一覧を作成
              /*categoriesの中身を一つずつ取り出して、
              DropdownMenuItemに変換する*/
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),//mpaはIterabel型だからList型に変換する
              //選択肢が選ばれたときの処理
              onChanged: (value) {
                if (value != null) {
                  //画面を更新する
                  setState(() {
                    //選択されたカテゴリの保持
                    selectedCategory = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
              //ボタンを押したときの処理

                print('金額: ${moneyController.text}, カテゴリ: $selectedCategory');
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