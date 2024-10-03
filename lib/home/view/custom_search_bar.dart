import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_bloc.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_event.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_state.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  Timer? _debounce;

  bool showLoadingProgress = false;

  void _onSearchChanged(BuildContext context, String value) {
    // Hủy Timer cũ nếu có
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Tạo Timer mới
    _debounce = Timer(const Duration(seconds: 1), () {
      if (value.isNotEmpty) {
        context.read<HomeBloc>().add(SearchEvent(value));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is StartSearchState) {
          showLoadingProgress = true;
        }

        if (state is SearchedState) {
          showLoadingProgress = false;
        }

        return Container(
          margin: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Material(
            elevation: 2.0, // Độ nổi của TextField
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                if (value.isEmpty) {
                  context.read<HomeBloc>().add(SearchEvent(value));
                }
                _onSearchChanged(context, value);
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: showLoadingProgress
                    ? Transform.rotate(
                        angle: 1.0, // Rotate the icon
                        child: const Icon(
                          Icons.autorenew, // Use a refresh icon for loading
                          size: 24,
                          color: Colors.black,
                        ),
                      )
                    : const Icon(Icons.search, size: 24),
                suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              context.read<HomeBloc>().add(SearchEvent(''));
                            },
                          )
                        : const SizedBox
                            .shrink(); // Widget rỗng khi không có văn bản
                  },
                ),
                hintText: "Enter keyword",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none, // Không có viền rõ ràng
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
