import 'package:cached_network_image/cached_network_image.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_event.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../ui/appbar.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (BuildContext context, state) {
      final searchProducts = state.productsBlocModel;
      return Scaffold(
          appBar: PreferredSize(
              preferredSize:
                  Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
              child: AppBarWidget(
                readOnly: false,
                onTap: () {},
                autofocus: true,
                appbarLeading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                ),
                appbarTitle: const Text(
                  "Search",
                  // style: TextStyle(color: Color(0xFF56AE7C)),
                ),
                onChange: (text) {
                  context
                      .read<ProductsBloc>()
                      .add(GetSearchProductEvent(searchText: text));
                },
                implyLeading: true,
              )),
          body: Container(
            // color: const Color(0xFF151A20),
            child: ListView.builder(
                itemExtent: 160,
                itemCount: searchProducts.filteredProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = searchProducts.filteredProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            // color: const Color(0xFF212934),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: product.getImage(),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                height: 150,
                                width: 130,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    product.name ?? "",
                                    // style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$${product.price}" ?? "",
                                    // style:
                                    // const TextStyle(color: Color(0xFF56AE7C)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    product.description ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    // style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite_border,
                                      // color: const Color(0xFF56AE7C),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: BlocBuilder<CartBloc, CartBlocState>(
                                      builder: (BuildContext context, state) {
                                        if (state.cartBlocModel.isAddToCart(product)) {
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              state.cartBlocModel.productQuantity == 1
                                                  ? TextButton(
                                                  onPressed: () {
                                                    context.read<CartBloc>().add(
                                                        RemoveFromCartEvent(product: product));
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Color(0xFF56AE7C),
                                                  ))
                                                  : TextButton(
                                                onPressed: () => context
                                                    .read<CartBloc>()
                                                    .add(RemoveQuantityEvent(product: product)),
                                                child: const Icon(
                                                  Icons.remove,
                                                  // color: Color(0xFF56AE7C),
                                                ),
                                              ),
                                              Text(
                                                "${state.cartBlocModel.productQuantity}",
                                                // style: const TextStyle(color: Colors.white),
                                              ),
                                              TextButton(
                                                onPressed: () => context
                                                    .read<CartBloc>()
                                                    .add(AddQuantityEvent(product: product)),
                                                child: const Icon(
                                                  Icons.add,
                                                  // color: Color(0xFF56AE7C),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return OutlinedButton(
                                              onPressed: () {
                                                context
                                                    .read<CartBloc>()
                                                    .add(AddCartEvent(product: product));
                                              },
                                              child: const Text(
                                                "Add to Cart",
                                                // style: TextStyle(color: Colors.white),
                                              ));
                                        }
                                        // }
                                      }),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ));
    });
  }
}
