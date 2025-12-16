import 'package:dio/dio.dart';
import 'package:flutter_lessons/lessons/bai12_product/product.dart';

class API{
  Future<List<Product>> getAllProduct() async {
    var dio = Dio();
    var url = 'https://fakestoreapi.com/products';
    var response = await dio.request(url);
    List<Product> ls = [];
    if (response.statusCode == 200){
      List data = response.data;
      ls = data.map(
        (json) =>Product.fromJson(json)
      ).toList();
    }
    else{
      print('Có lỗi gì đó rồi');
    }
    return ls;
  }
}
var test = API();