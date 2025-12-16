import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {//cành nằm đâu lá nằm đó
    return Scaffold(//cây (5 thành phần: navbar,body,footer,..)
      body: Column(// cha ba cành
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(
            'Hello World',
            style: TextStyle(color: Colors.red,fontSize: 30),)//cành 1
            ),

            Icon(Icons.heart_broken,size: 100,color: Colors.red,),//cành 2

            Text("Lập Trình Di Dộng - Nhóm 2", style: TextStyle(color:Colors.blueAccent,fontSize: 30 ),),//cành 3
        ],
      ) // với cha cành là center nhấn phải chọn Refactor lá cây nên ko chứa lá
    );
  }
}