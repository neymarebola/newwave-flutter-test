import 'package:newwave_solution_flutter_test/home/model/place_model.dart';

class ApiResponse {
  List<Place> items;

  ApiResponse({required this.items});

  // Tạo đối tượng từ JSON
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    List<Place> filteredItems = [];

    // Kiểm tra nếu 'items' là một List
    if (json['items'] != null && json['items'] is List) {
      for (var v in json['items']) {
        if (v['position'] != null) {
          filteredItems.add(Place.fromJson(v));
        }
      }
    }

    return ApiResponse(items: filteredItems);
  }
}