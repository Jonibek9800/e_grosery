import 'package:flutter/material.dart';

import '../ui/appbar.dart';

class WishlistPageWidget extends StatelessWidget {
  const WishlistPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size(MediaQuery.of(context).size.width, kToolbarHeight * 2),
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
            )),
        body: Container(
          // color: const Color(0xFF151A20),
          child: const Center(
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
          ),
        ));
  }
}
