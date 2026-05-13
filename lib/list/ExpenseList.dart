import 'package:flutter/material.dart';
import '/list/ExpensePage.dart';
 
class Expenselist extends StatelessWidget{
 
  final VoidCallback? onExpense;
  const Expenselist(this.onExpense, {super.key});//onExpenseに変更
 
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: listViewBuilder()
    );
  }
 
  Widget buildListView(){
    return ListView(
      children: [
        //CouponListItem(onPressed),
        //CouponListItem(onPressed),
        //CouponListItem(onPressed),
      ],
    );
  }
 
 
  //  データの個数に従って、表示する場合
  static const items = [0,1,2,3,4,5,6];
 
  Widget listViewBuilder(){
    return ListView.builder(
      itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Expenselist(onExpense ?? () {});
        }
    );
  }
}