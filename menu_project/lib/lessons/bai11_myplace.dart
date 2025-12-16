import 'package:flutter/material.dart';

class MyPage extends StatelessWidget{
  const MyPage({super.key});

  Widget build(BuildContext context){
    return Scaffold(
      body: 
      ListView(
        children: [
          block1(),
          block2(),
          SizedBox(height: 30,),
          block3(),
          SizedBox(height: 30,),
          block4(),
        ],
      ),
    );
  }
  Widget block1(){
    var src = "https://i.ex-cdn.com/vietnamfinance.vn/files/content/2024/08/08/1-tang-truong-viet-nam-1204.jpg";
    return Image.network(src);
  }
  Widget block2(){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:[
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Việt Nam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                SizedBox(height: 10,),
                Text('Thủ đô: Hà Nội Dân số: 101 triệu (2024) Ngân hàng Thế giới Các tỉnh: Thái Nguyên, Đắk Lắk, Đà Nẵng, Nghệ An, Gia Lai,.. Thủ tướng: Phạm Minh Chính'
                ,style: TextStyle(fontSize: 20),
                ),],
            ),
            ),
            SizedBox(width: 30,),
            Row(
              children: [
                const Icon(Icons.star,color: Colors.red,size: 40),
                SizedBox(width: 20,),
                const Text('41',style: TextStyle(fontSize: 40),),
              ],
            ),
        ],
      ),
    );
  }
  Widget block3(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BuildButton(Icons.call,'CALL'),
        BuildButton(Icons.near_me,'ROUTE'),
        BuildButton(Icons.share,'SHARE'),
      ],
    );
  }
  Widget BuildButton(IconData icon,String label){
    return Column(
      children: [
        Icon(icon,color: Colors.blue,size: 30,),
        SizedBox(height: 10,),
        Text(label, style: TextStyle(fontSize: 20,color: Colors.blue),)
      ]
    );
  }
  Widget block4(){
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: 
      Text("Việt Nam, quốc hiệu đầy đủ là Cộng hòa xã hội chủ nghĩa Việt Nam, là một quốc gia nằm ở cực Đông của bán đảo Đông Dương thuộc khu vực Đông Nam Á, giáp với Lào, Campuchia, Trung Quốc, biển Đông và vịnh Thái Lan.",
      style: TextStyle(fontSize: 20),textAlign: TextAlign.justify,),   
    );
  }
}
