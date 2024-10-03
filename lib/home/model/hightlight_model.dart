class Highlight {
  int start;
  int end;

  Highlight({required this.start, required this.end});

  // Tạo đối tượng từ JSON
  factory Highlight.fromJson(Map<String, dynamic> json) {
    return Highlight(
      start: json['start'] ?? 0, // Cung cấp giá trị mặc định nếu không có
      end: json['end'] ?? 0, // Cung cấp giá trị mặc định nếu không có
    );
  }
}
