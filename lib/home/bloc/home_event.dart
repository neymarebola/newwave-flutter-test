abstract class HomeEvent {}

class SearchEvent extends HomeEvent {
  String query;

  SearchEvent(this.query);
}
