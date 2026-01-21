import 'package:flutter/material.dart';
 
class MainContent extends StatelessWidget{
 
final VoidCallback onExpense;
final VoidCallback onIncome;
const MainContent({
  required this.onExpense,
  required this.onIncome,
  super.key,
});
 
 @override
Widget build(BuildContext context) {
  return Column(
    children: [
      // タイトル
      Padding(
        padding: const EdgeInsets.only(top: 60, bottom: 20),
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

      
      SizedBox(
        // 出費ボタン
        height: 430,//430で統一
        width: 300,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onExpense,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.red),
                  foregroundColor:
                      WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("出費"),
                    
                  ),
                ),
              ),

              // 収入ボタン
              ElevatedButton(
                onPressed: onIncome,
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      WidgetStateProperty.all<Color>(Colors.white),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("収入"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

}
 