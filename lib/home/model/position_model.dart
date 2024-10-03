class Position {
  double lat;
  double lng;

  Position({required this.lat, required this.lng});

  // Tạo đối tượng từ JSON
  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      lat: json['lat']?.toDouble() ?? 0.0, // Cung cấp giá trị mặc định nếu không có
      lng: json['lng']?.toDouble() ?? 0.0, // Cung cấp giá trị mặc định nếu không có
    );
  }
}