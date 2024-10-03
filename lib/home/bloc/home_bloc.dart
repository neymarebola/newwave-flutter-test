import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_event.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_state.dart';
import 'package:newwave_solution_flutter_test/home/model/place_model.dart';
import 'package:newwave_solution_flutter_test/repository/search_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.searchRepository}) : super(InitialState()) {
    on<SearchEvent>(_onSearchEvent);
  }

  final SearchRepository searchRepository;

  Future<void> _onSearchEvent(
    SearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    String query = event.query;
    emit(StartSearchState());
    await searchRepository.searchPlaces(query).then((value) {
      emit(SearchedState(value));
    });
  }
}
