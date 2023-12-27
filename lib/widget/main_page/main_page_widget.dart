import 'package:el_grocer/widget/main_page/main_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageWidget extends StatelessWidget {
  const MainPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainViewBlocState>(
        builder: (BuildContext context, state) {
      final selectedIndex = state.mainViewModel.nextPageIndex;
      return Scaffold(
        body: Center(
          child: state.mainViewModel.widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Color(0xFF212934),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.zoom_out_map),
              label: 'Categories',
              // backgroundColor: Color(0xFF212934),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Wishlist',
              // backgroundColor: Color(0xFF212934),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              // backgroundColor: Color(0xFF212934),
            ),
          ],
          currentIndex: selectedIndex,
          // selectedIconTheme: const IconThemeData(color: Color(0xFF56AE7C)),
          // selectedItemColor: Colors.white,
          onTap: (index) {
            context.read<MainBloc>().add(NextPageBlocEvent(index: index));
          },
        ),
      );
    });
  }
}

