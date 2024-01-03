import 'package:el_grocer/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc.dart';
import 'package:el_grocer/domain/blocs/products_bloc/products_bloc_state.dart';
import 'package:el_grocer/domain/blocs/themes/themes_model.dart';
import 'package:el_grocer/routes/routes.dart';
import 'package:el_grocer/widget/ui/product_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';
import '../../domain/blocs/products_bloc/products_bloc_event.dart';
import '../../domain/blocs/themes/themes_bloc.dart';
import '../ui/appbar.dart';

class ProductsWidget extends StatefulWidget {
  const ProductsWidget({super.key});

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        context.read<ProductsBloc>().add(GetNextProductPageEvent(sortMethod: 'asc', sortName: 'id'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartBlocState>(builder: (context, cartState) {
      return BlocBuilder<ProductsBloc, ProductsBlocState>(
        builder: (BuildContext contexts, state) {
          final productModel = state.productsBlocModel;
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
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
                    voiceCallback: () {
                      Navigator.of(context).pushNamed(MainNavigationRouteNames.searchPage);
                    },
                  )),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    // isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.vertical(top: Radius.circular(10))),
                                    context: context,
                                    // backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(Icons.arrow_back)),
                                          const _RadioListThemes(),
                                        ],
                                      );
                                    });
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.sort),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("Sort By"),
                                ],
                              )),
                        ),
                      ),
                      Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.list),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text("ListView"),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      controller: _scrollController,
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemExtent: 160,
                            itemCount: productModel.allProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final product = productModel.allProducts[index];
                              return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        MainNavigationRouteNames.productCard,
                                        arguments: product,
                                      );
                                    },
                                    child: ProductPageWidget(
                                      product: product,
                                    ),
                                  ));
                            }),
                        if (productModel.allProducts.length < (productModel.totalCount ?? 0))
                          Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ThemeColor.greenColor,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ));
        },
      );
    });
  }
}

class _RadioListThemes extends StatelessWidget {
  const _RadioListThemes();

  // ThemesState? _character = ThemesState.light;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemesBloc, ThemesBlocState>(builder: (BuildContext context, state) {
      return ListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int i = 0; i < 2; i++)
            RadioListTile<ThemesState>(
              // activeColor: Colors.green,
              title: const Text(
                'Light',
              ),
              value: ThemesState.light,
              groupValue: state.themesModel.currentState,
              onChanged: (value) {
                context.read<ThemesBloc>().add(ThemesLightEvent(value: value));
                Navigator.of(context).pop();
              },
            ),
          RadioListTile<ThemesState>(
            // activeColor: Colors.green,
            title: const Text(
              'Dark',
              // style: TextStyle(color: Colors.white),
            ),
            value: ThemesState.dark,
            groupValue: state.themesModel.currentState,
            onChanged: (ThemesState? value) {
              context.read<ThemesBloc>().add(ThemesLightEvent(value: value));
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    });
  }
}
