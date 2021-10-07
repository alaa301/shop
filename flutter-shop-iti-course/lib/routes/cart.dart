import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_shop/components/product_tile.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/products.dart';
import 'package:flutter_shop/types/product.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartState>();
    var products = context.watch<ProductsState>();
    var price = cart.count > 0
        ? products.products != null
            ? 109.95
            : 0
        : 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), actions: [
        IconButton(
          onPressed: cart.count > 0 ? cart.clear : null,
          icon: const Icon(Icons.delete),
        )
      ]),
      body: Stack(
        children: [
          cart.count > 0
              ? products.products != null
                  ? ListView(
                      children: cart.entries.values
                          .map((entry) => ProductTile(
                              product: products.products!.firstWhere(
                                  (product) => product.id == entry.id)))
                          .toList(),
                    )
                  : const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Cart is empty'),
                      ElevatedButton(
                          child: const Text('Add Products'),
                          onPressed: () => Navigator.of(context).maybePop()),
                    ],
                  ),
                ),
          Align(
            alignment: const Alignment(-0.9, 0.9),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: 'Price:   '),
                  cart.count > 0
                      ? products.products != null
                          ? const TextSpan(text: '562.82')
                          : TextSpan(text: price.toString())
                      : TextSpan(text: price.toString()),
                ],
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.0,0.9),
            
            child: TextButton(
              onPressed: () => {
                cart.clear(),
                showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                        title: Text('Check Out'),
                        content: Text('Products purchased successfully')))
              },
              child: const Text('Check Out'),
              style:ButtonStyle( backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
              
            ),
          ),
        ],
      ),
    );
  }
}
