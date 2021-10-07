import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_shop/routes/jewelery.dart';
import 'package:flutter_shop/types/product.dart';
import 'package:http/http.dart' as http;

class ProductsState extends ChangeNotifier {
  List<Product>? products;
  List<Product>? productsE;
  List<Product>? productsJ;
  List<Product>? productsM;
  List<Product>? productsW;

  ProductsState() {
    refresh();
  }

  Future<void> refresh() async {
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));    
    var responseE = 
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/electronics'));
    var responseJ = 
        await http.get(Uri.parse('https://fakestoreapi.com/products/category/jewelery'));
    var responseM = 
        await http.get(Uri.parse("https://fakestoreapi.com/products/category/men's%20clothing"));
    var responseW = 
        await http.get(Uri.parse("https://fakestoreapi.com/products/category/women's clothing"));
    
    
    
    
    var json = jsonDecode(response.body);
    var jsonE = jsonDecode(responseE.body);
    var jsonJ = jsonDecode(responseJ.body);
    var jsonM = jsonDecode(responseM.body);
    var jsonW = jsonDecode(responseW.body);
    

    products = (json as List<dynamic>)
        .map((value) => Product.fromJson(value))
        .toList();

    productsE = (jsonE as List<dynamic>)
        .map((value) => Product.fromJson(value))
        .toList();

    productsJ = (jsonJ as List<dynamic>)
    .map((value) => Product.fromJson(value))
    .toList();

    productsM = (jsonM as List<dynamic>)
        .map((value) => Product.fromJson(value))
        .toList();

    productsW = (jsonW as List<dynamic>)
        .map((value) => Product.fromJson(value))
        .toList();

    notifyListeners();
  }
}
