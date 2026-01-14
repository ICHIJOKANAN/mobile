import 'package:flutter/material.dart';
 
class MainContent extends StatelessWidget{
 
  final VoidCallback? onPressed;
  const MainContent(this.onPressed, {super.key});
 
  @override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: (){
            // （1） 指定した画面に遷移する
            Navigator.push(context, MaterialPageRoute(
              // （2） 実際に表示するページ(ウィジェット)を指定する
              builder: (context) => ()
            ));
          },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text("出費"),
          ),

          SizedBox(width: 20), // ボタン間のすき間

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IncomePage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text("収入"),
          ),
        ],
      ),
    ),
  );
}

}
 