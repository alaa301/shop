import 'package:flutter/material.dart';
import 'package:flutter_shop/components/product_tile.dart';
import 'package:flutter_shop/providers/favorites.dart';
import 'package:flutter_shop/providers/products.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductsState>();
    var favorites = context.watch<FavoritesState>();

    if (products.products == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: ReorderableListView(
          onReorder: favorites.reorder,
          children: favorites.ids.map((id) {
            var product =
                products.products!.firstWhere((element) => element.id == id);

            return ProductTile(
                key: Key(product.id.toString()), product: product);
          }).toList()),
    );
  }
}
