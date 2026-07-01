import 'package:flutter/material.dart';
import 'list/MainContent.dart'; 
import 'list/ExpensePage.dart';
import 'list/IncomePage.dart';


class MainPageWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MainPageWidget();
  }

}


class _MainPageWidget extends State<MainPageWidget>{



/*
  // 詳細画面を表示する
  void openDetail(){
    setState(() {
      // 未使用
    });
  }
  // 詳細画面を消す
  void closeDetail(){
    setState(() {
      // 未使用
    });
  }
*/


@override
Widget build(BuildContext context) {
  return Scaffold(
    body: MainContent(
      onExpense: () {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ExpensePage(),
          ),
        ).then((result) {
          if (!mounted) return;
          if (result == 'expense_saved') {
            messenger.showSnackBar(
              const SnackBar(content: Text('出費を保存しました')),
            );
            setState(() {});
          }
        });
      },
      onIncome: () {
        final messenger = ScaffoldMessenger.of(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const IncomePage(),
          ),
        ).then((result) {
          if (!mounted) return;
          if (result == 'income_saved') {
            messenger.showSnackBar(
              const SnackBar(content: Text('収入を保存しました')),
            );
            setState(() {});
          }
        });
      },
    ),
  );
}

  
}
