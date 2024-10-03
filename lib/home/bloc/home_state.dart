import '../model/place_model.dart';

abstract class HomeState {}


class InitialState extends HomeState {}

class StartSearchState extends HomeState {}

class SearchedState extends HomeState {
  List<Place>? places;
  SearchedState(this.places);
}
