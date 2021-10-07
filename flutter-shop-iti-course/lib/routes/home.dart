import 'package:flutter/material.dart';
import 'package:flutter_shop/components/product_card.dart';
import 'package:flutter_shop/components/product_tile.dart';
import 'package:flutter_shop/providers/cart.dart';
import 'package:flutter_shop/providers/products.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartState>();
    var products = context.watch<ProductsState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Padding(padding: EdgeInsets.all(4.0), child: FlutterLogo()),
              Text('Shop'),
            ],
          ),
          actions: [
            IconButton(
                icon: const Icon(Icons.view_headline),
                onPressed: () => Navigator.of(context).pushNamed('/category')),
            IconButton(
                icon: const Icon(Icons.favorite),
                onPressed: () => Navigator.of(context).pushNamed('/favorites')),
            IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/cart'),
                icon: Stack(children: [
                  const Icon(Icons.shopping_cart),
                  Positioned(
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        cart.count.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ]))
          ],
          bottom: const TabBar(tabs: [Tab(text: 'Grid'), Tab(text: 'List')]),
        ),
        body: products.products == null
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  RefreshIndicator(
                    onRefresh: products.refresh,
                    child: GridView(
                        // scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 300, childAspectRatio: .6),
                        children: products.products!
                            .map((product) => ProductCard(product: product))
                            .toList()),
                  ),
                  RefreshIndicator(
                      onRefresh: products.refresh,
                      child: ListView(
                          children: products.products!
                              .map((product) => ProductTile(product: product))
                              .toList()))
                ],
              ),
      ),
    );
  }
}
