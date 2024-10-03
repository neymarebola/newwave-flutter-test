import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newwave_solution_flutter_test/repository/search_repository.dart';

import 'app.dart';
import 'observer/simple_bloc_observer.dart';

void main() {
  Bloc.observer = const SimpleBlocObserver();
  runApp(App(searchRepository: SearchRepository()));
}
