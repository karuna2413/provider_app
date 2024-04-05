import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerapp/model/product.dart';
import 'package:providerapp/service/productService.dart';

class ProductProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Product> productList = [];
  var err;
  ProductService productService = ProductService();
  getData() async {
    isLoading = true;
    notifyListeners();
    final res = await productService.fetchData();
    if (res.runtimeType == List<Product>) {
      productList = res;
    } else {
      err = res;
    }
    // err = productService.err;
    // productList = res;
    print('resp${res.runtimeType}');
    print('res$err');

    isLoading = false;
    notifyListeners();
  }
}
