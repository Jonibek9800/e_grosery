import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_cubit.dart';
import 'package:el_grocer/domain/blocs/favorite_cubit/favorite_cubit_state.dart';
import 'package:el_grocer/routes/routes.dart';
import 'package:el_grocer/widget/ui/product_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ui/appbar.dart';

class WishlistPageWidget extends StatelessWidget {
  const WishlistPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteCubitState>(builder: (BuildContext context, state) {
      final favoriteModel = state.favoriteModel;
      debugPrint("${favoriteModel?.favoriteList}");
      return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
              child: AppBarWidget(
                readOnly: true,
                onTap: () {
                  Navigator.of(context).pushNamed("/search_page");
                },
                autofocus: false,
                appbarTitle: const Text(
                  "Wishlist",
                  // style: TextStyle(color: Color(0xFF56AE7C)),
                ),
                implyLeading: false,
                voiceCallback: () {
                  Navigator.of(context).pushNamed(MainNavigationRouteNames.searchPage);
                },
              )),
          body: favoriteModel?.favoriteList?.length == 0
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt_sharp,
                        color: Color(0xFF56AE7C),
                        size: 104,
                      ),
                      Text(
                        "Wishlist is Empty",
                        style: TextStyle(
                          color: Color(0xFF56AE7C),
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Create your personalized collection of must-haves!!",
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: favoriteModel?.favoriteList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final favorite = favoriteModel?.favoriteList?[index];
                    return ProductPageWidget(product: favorite?.product);
                  }));
    });
  }
}
