import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_bloc.dart';
import 'package:newwave_solution_flutter_test/home/view/home_page.dart';
import 'package:newwave_solution_flutter_test/repository/search_repository.dart';

class App extends StatelessWidget {
  const App({required this.searchRepository, super.key});

  final SearchRepository searchRepository;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => HomeBloc(searchRepository: searchRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Bloc Shopping Cart',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        // theme: ThemeData(
        //   dividerColor: Colors.transparent,
        // ),
        initialRoute: '/',
        routes: {
          '/': (_) => HomePage(),
          //  '/cart': (_) => const CartPage(),
        },
      ),
    );
  }
}
