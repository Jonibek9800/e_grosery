import 'package:el_grocer/user_app/domain/blocs/sort_bloc/sort_bloc_model.dart';

class SortBlocState {
  SortCubitModel sortAndListCubitModel;

  SortBlocState({required this.sortAndListCubitModel});
}

class InitSortCubitState extends SortBlocState {
  InitSortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}

class SortedBySortCubitState extends SortBlocState {
  SortedBySortCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}

class SortByAllProductCubitState extends SortBlocState {
  SortByAllProductCubitState({required SortCubitModel sortAndListCubitModel})
      : super(sortAndListCubitModel: sortAndListCubitModel);
}
// class OldestSortCubitState extends SortBlocState {
//   OldestSortCubitState({required SortCubitModel sortAndListCubitModel})
//       : super(sortAndListCubitModel: sortAndListCubitModel);
// }
// class HighToLowSortCubitState extends SortBlocState {
//   HighToLowSortCubitState({required SortCubitModel sortAndListCubitModel})
//       : super(sortAndListCubitModel: sortAndListCubitModel);
// }
// class LowToHighSortCubitState extends SortBlocState {
//   LowToHighSortCubitState({required SortCubitModel sortAndListCubitModel})
//       : super(sortAndListCubitModel: sortAndListCubitModel);
// }