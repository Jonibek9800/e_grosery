import 'package:el_grocer/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:el_grocer/widget/ui/product_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../ui/appbar.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(builder: (context, cartState) {
      // var currentCartState = cartState.cartBlocModel;
      return BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (BuildContext contexts, state) {
          final products = state.productsBlocModel.allProducts;
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(
                      MediaQuery.of(context).size.width, kToolbarHeight * 2),
                  child: AppBarWidget(
                    readOnly: true,
                    onTap: () {
                      Navigator.of(context).pushNamed("/search_page");
                    },
                    autofocus: false,
                    appbarLeading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_outlined),
                    ),
                    appbarTitle: const Text(
                      "Products",
                      style: TextStyle(color: Color(0xFF56AE7C)),
                    ),
                    implyLeading: true,
                  )),
              body: Container(
                // color: const Color(0xFF151A20),
                child: ListView.builder(
                    itemExtent: 160,
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      final product = products[index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                          child: ProductPageWidget(
                            product: product,
                          ));
                    }),
              ));
        },
      );
    });
  }
}
