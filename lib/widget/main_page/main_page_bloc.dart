import 'package:bloc/bloc.dart';
import 'package:el_grocer/widget/profile_page/profile_page_widget.dart';
import 'package:el_grocer/widget/wishlist_page/wishlist_page_widget.dart';
import 'package:flutter/cupertino.dart';

import '../categories_page/categories_widget.dart';
import '../home_page/home_page_widget.dart';

class MainViewModel {
  int nextPageIndex = 0;

  final List<Widget> widgetOptions = <Widget>[
    const HomePageWidget(),
    const CategoriesWidget(),
    const WishlistPageWidget(),
    const ProfilePageWidget(),
  ];
}

abstract class MainViewBlocState {
  MainViewModel mainViewModel;

  MainViewBlocState({required this.mainViewModel});
}

class NextPageBlocState extends MainViewBlocState {
  NextPageBlocState({required MainViewModel mainViewModel})
      : super(mainViewModel: mainViewModel);
}

//===========================================================================

abstract class MainViewBlocEvent {}

class NextPageBlocEvent extends MainViewBlocEvent {
  var index = 0;

  NextPageBlocEvent({required this.index});
}

class MainBloc extends Bloc<MainViewBlocEvent, MainViewBlocState> {
  MainBloc() : super(NextPageBlocState(mainViewModel: MainViewModel())) {
    on<NextPageBlocEvent>((event, emit) {
      final currentState = state.mainViewModel;
      currentState.nextPageIndex = event.index;
      emit(NextPageBlocState(mainViewModel: currentState));
    });
  }
}
