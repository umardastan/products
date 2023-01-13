import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:list_product/app/models/product.dart';

class Services {
  String baseUrl = 'https://dummyjson.com/products';
  Future<Map<String, dynamic>?> getProduct() async {
    var url = Uri.parse(baseUrl);
    var response = await http.get(url,
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode != 200) {
      print('data tidak ditemukan');
      return null;
    } else {
      Map<String, dynamic>? data =
          (jsonDecode(response.body) as Map<String, dynamic>)['products'];
      print('data ditemukan');
      print(data);
      return data;
    }
    // var products = (json.decode(response.body))['products'];
    // print('ini dari services get product');
    // print(products);
    // return products.map((e) => Product.fromJson(e)).toList();
  }

  Future<List<Product>> getProductList() async {
    final response = await http
        .get(Uri.parse(baseUrl), headers: {"Content-Type": "application/json"});
    List jsonResponse = (json.decode(response.body))['products'];
    return jsonResponse.map((product) => Product.fromJson(product)).toList();
  }
}
