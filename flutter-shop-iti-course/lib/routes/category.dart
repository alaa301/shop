import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/components/product_tile.dart';
import 'package:flutter_shop/providers/favorites.dart';
import 'package:flutter_shop/providers/products.dart';
import 'package:provider/provider.dart';

import 'package:flutter/services.dart';

  var car = const [
            "electronics",
            "jewelery",
            "men_clothes",
            "women_clothes"
            ];

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Category')),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(4, (index) {
            return Center(
              child: RichText(text: TextSpan(
                text: '${car[index]}',
                style: Theme.of(context).textTheme.headline5,
                recognizer: TapGestureRecognizer() ..onTap = ()=> Navigator.of(context).pushNamed('/${car[index]}') , 
              ),)
              
            );
          }),
        ),
      );
  }
}
