import 'package:flutter/material.dart';
 
class MainContent extends StatelessWidget{
 
  final VoidCallback? onPressed;
  const MainContent(this.onPressed, {super.key});
 
 @override
Widget build(BuildContext context) {
  return Column(
    children: [
      
      SizedBox(
        height: 20,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: onPressed ?? () {},
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
                onPressed: onPressed ?? () {},
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
 