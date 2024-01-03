import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc.dart';

class SortBlocEvent {}

class DefaultSortBlocEvent extends SortBlocEvent {
  SortState? defaultSort;

  DefaultSortBlocEvent({required this.defaultSort});
}

class NewestSortBlocEvent extends SortBlocEvent {
  SortState? newest;

  NewestSortBlocEvent({required this.newest});
}

class OldestSortBlocEvent extends SortBlocEvent {
  SortState? oldest;

  OldestSortBlocEvent({required this.oldest});
}

class HighToLowSortBlocEvent extends SortBlocEvent {
  SortState? highToLow;

  HighToLowSortBlocEvent({required this.highToLow});
}

class LowToHighSortBlocEvent extends SortBlocEvent {
  SortState? lowToHigh;

  LowToHighSortBlocEvent({required this.lowToHigh});
}
