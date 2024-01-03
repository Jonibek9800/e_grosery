import 'package:bloc/bloc.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_event.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_model.dart';
import 'package:el_grocer/domain/blocs/sort_bloc/sort_bloc_state.dart';

enum SortState { defaultSort, newestFirs, oldestFirst, highToLow, lowToHigh }

class SortBloc extends Bloc<SortBlocEvent, SortBlocState> {
  SortBloc() : super(InitSortCubitState(sortAndListCubitModel: SortCubitModel())) {
    final current = state.sortAndListCubitModel;
    on<DefaultSortBlocEvent>((event, emit) {
      current.sortState = event.defaultSort ?? SortState.defaultSort;
      emit(DefaultSortCubitState(sortAndListCubitModel: current));
    });
    on<NewestSortBlocEvent>((event, emit) {
      current.sortState = event.newest ?? SortState.newestFirs;
      emit(NewestSortCubitState(sortAndListCubitModel: current));
    });
    on<OldestSortBlocEvent>((event, emit) {
      current.sortState = event.oldest ?? SortState.oldestFirst;
      emit(OldestSortCubitState(sortAndListCubitModel: current));
    });
    on<HighToLowSortBlocEvent>((event, emit) {
      current.sortState = event.highToLow ?? SortState.highToLow;
      emit(HighToLowSortCubitState(sortAndListCubitModel: current));
    });
    on<LowToHighSortBlocEvent>((event, emit) {
      current.sortState = event.lowToHigh ?? SortState.lowToHigh;
      emit(LowToHighSortCubitState(sortAndListCubitModel: current));
    });
  }
}
