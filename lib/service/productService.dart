import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/product.dart';

class ProductService {
  List<dynamic> data = [];
  String? err;
  fetchData() async {
    try {
      Response response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      print(response.statusCode);
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
        print('data$data');
        return data.map((userJson) => Product.fromJson(userJson)).toList();
      } else {
        err = response.statusCode.toString();
        return err;
      }
    } catch (e) {
      err = e.toString();
      return err;
    }
  }
}
