import 'package:newwave_solution_flutter_test/home/model/hightlight_model.dart';
import 'package:newwave_solution_flutter_test/home/model/position_model.dart';

class Place {
  String title; // Title is required
  Position? position; // Position is nullable
  List<Highlight> highlightTitles; // HighlightTitles is required

  Place({
    required this.title,
    this.position,
    required this.highlightTitles,
  });

  // Tạo đối tượng từ JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'] ?? '', // Cung cấp giá trị mặc định nếu không có
      position: json['position'] != null
          ? Position.fromJson(json['position'])
          : null,
      highlightTitles: json['highlights'] != null
          ? (json['highlights']['title'] as List)
          .map((e) => Highlight.fromJson(e))
          .toList()
          : [], // Khởi tạo danh sách rỗng nếu không có highlights
    );
  }
}