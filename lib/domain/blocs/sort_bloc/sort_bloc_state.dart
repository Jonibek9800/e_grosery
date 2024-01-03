import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_model.dart';

class SortBlocState {
  SortCubitModel sortAndListCubitModel;

  SortBlocState({required this.sortAndListCubitModel});
}

class InitSortCubitState extends SortBlocState {
  InitSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}

class DefaultSortCubitState extends SortBlocState {
  DefaultSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}

class NewestSortCubitState extends SortBlocState {
  NewestSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}
class OldestSortCubitState extends SortBlocState {
  OldestSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}
class HighToLowSortCubitState extends SortBlocState {
  HighToLowSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}
class LowToHighSortCubitState extends SortBlocState {
  LowToHighSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}