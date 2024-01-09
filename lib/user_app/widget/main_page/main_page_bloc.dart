import 'package:bloc/bloc.dart';
import 'package:el_grocer/admin_app/admin_widget/edit_widget/edit_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/user.dart';
import '../categories_page/categories_widget.dart';
import '../home_page/home_page_widget.dart';
import '../profile_page/profile_page_widget.dart';
import '../wishlist_page/wishlist_page_widget.dart';

class MainViewModel {
  int nextPageIndex = 0;

  final List<Widget> widgetOptions = <Widget>[
    const HomePageWidget(),
    const CategoriesWidget(),
    const WishlistPageWidget(),
    const ProfilePageWidget(),
  ];

  final List<BottomNavigationBarItem> bottomNavigationBarItem = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.zoom_out_map),
      label: 'Categories',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
      // backgroundColor: Color(0xFF212934),
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
      // backgroundColor: Color(0xFF212934),
    ),
  ];
}

abstract class MainViewBlocState {
  MainViewModel mainViewModel;

  MainViewBlocState({required this.mainViewModel});
}

class InitUserFromMainState extends MainViewBlocState {
  InitUserFromMainState({required MainViewModel mainViewModel})
      : super(mainViewModel: mainViewModel);
}

class NextPageBlocState extends MainViewBlocState {
  NextPageBlocState({required MainViewModel mainViewModel}) : super(mainViewModel: mainViewModel);
}

//===========================================================================

abstract class MainViewBlocEvent {}

class NextPageBlocEvent extends MainViewBlocEvent {
  var index = 0;

  NextPageBlocEvent({required this.index});
}

class InitUserFromMainEvent extends MainViewBlocEvent {
  User? user;

  InitUserFromMainEvent({required this.user});
}

class MainBloc extends Bloc<MainViewBlocEvent, MainViewBlocState> {
  MainBloc() : super(NextPageBlocState(mainViewModel: MainViewModel())) {
    on<NextPageBlocEvent>((event, emit) {
      final currentState = state.mainViewModel;
      currentState.nextPageIndex = event.index;
      emit(NextPageBlocState(mainViewModel: currentState));
    });
    on<InitUserFromMainEvent>((event, emit) {
      final currentState = state.mainViewModel;
        debugPrint("user: ${event.user?.roleOfUserId}");
      if (event.user?.roleOfUserId == 2) {
        currentState.widgetOptions.add(const EditWidgetPage());
        currentState.bottomNavigationBarItem.add(const BottomNavigationBarItem(
          icon: Icon(Icons.edit),
          label: "Edit Page",
        ));
      }
      emit(InitUserFromMainState(mainViewModel: currentState));
    });
  }
}
