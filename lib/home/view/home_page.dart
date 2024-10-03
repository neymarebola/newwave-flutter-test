import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_bloc.dart';
import 'package:newwave_solution_flutter_test/home/bloc/home_state.dart';
import 'package:newwave_solution_flutter_test/home/model/place_model.dart';
import 'package:newwave_solution_flutter_test/home/view/custom_search_bar.dart';
import 'package:newwave_solution_flutter_test/utils/helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(height: 30),
          CustomSearchBar(), // Đặt CustomSearchBar ở trên cùng

          // BlocBuilder chỉ cho danh sách
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                List<Place> places = [];

                if (state is SearchedState) {
                  places.clear();
                  places.addAll(state.places ?? []);
                }

                return places.isNotEmpty ? ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    Place place = places[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 1, child: Icon(Icons.location_on_outlined)),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 8,
                            child: RichText(
                              text: TextSpan(
                                children: Helper.buildHighlightedText(
                                    place.title, place.highlightTitles),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: IconButton(
                              onPressed: () {
                                Helper.openGoogleMaps(place.position);
                              },
                              icon: const Icon(Icons.directions),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ) : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
