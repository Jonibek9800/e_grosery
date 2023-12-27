import 'package:cached_network_image/cached_network_image.dart';
import 'package:el_grocer/domain/entity/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';

class ProductPageWidget extends StatelessWidget {
  final Product product;

  const ProductPageWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DecoratedBox(
        decoration: BoxDecoration(
            // color: const Color(0xFF212934),
            borderRadius: BorderRadius.circular(10),),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: product.getImage(),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    height: 155,
                    width: 130,
                    fit: BoxFit.fill)),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$${product.price}" ?? "",
                    // style: const TextStyle(color: Color(0xFF56AE7C)),
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
                      // color: Color(0xFF56AE7C),
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
                            // final user =
                            //     context.read<AuthBloc>().state.authModel.user;
                            // if (user != null) {
                            context
                                .read<CartBloc>()
                                .add(AddCartEvent(product: product));
                            // } else {
                            //   showDialog(
                            //       context: context,
                            //       builder: (_) => const AlertDialogWidget());
                            // }
                          },
                          child: const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white),
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
    );
  }
}
