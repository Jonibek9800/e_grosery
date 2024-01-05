import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc.dart';

class SortBlocEvent {}

class InitSortCubitEvent extends SortBlocEvent{}

class SortBySearchBlocEvent extends SortBlocEvent {
  SortState? sortName;
  // String? sortMethod;

  SortBySearchBlocEvent({required this.sortName});
}

class SortByAllProductBlocEvent extends SortBlocEvent {
  SortState? sortName;

  SortByAllProductBlocEvent({required this.sortName});
}
//
// class OldestSortBlocEvent extends SortBlocEvent {
//   SortState? oldest;
//
//   OldestSortBlocEvent({required this.oldest});
// }
//
// class HighToLowSortBlocEvent extends SortBlocEvent {
//   SortState? highToLow;
//
//   HighToLowSortBlocEvent({required this.highToLow});
// }
//
// class LowToHighSortBlocEvent extends SortBlocEvent {
//   SortState? lowToHigh;
//
//   LowToHighSortBlocEvent({required this.lowToHigh});
// }
