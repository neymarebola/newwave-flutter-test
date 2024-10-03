import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newwave_solution_flutter_test/home/model/hightlight_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../home/model/position_model.dart';

class Helper {
  static List<TextSpan> buildHighlightedText(
      String title, List<Highlight> highlights) {
    List<TextSpan> spans = [];
    int lastEnd = 0;

    for (var highlight in highlights) {
      // Thêm phần văn bản không được highlight trước khi phần highlight
      if (highlight.start > lastEnd) {
        spans.add(TextSpan(
          text: title.substring(lastEnd, highlight.start),
          style: const TextStyle(color: Colors.grey),
        ));
      }

      // Thêm phần highlight
      spans.add(TextSpan(
        text: title.substring(highlight.start, highlight.end),
        style: const TextStyle(
          fontWeight: FontWeight.bold, // In đậm
          color: Colors.black, // Màu sắc nổi bật
        ),
      ));

      lastEnd = highlight.end;
    }

    // Thêm phần văn bản không được highlight sau phần highlight cuối
    if (lastEnd < title.length) {
      spans.add(TextSpan(
        text: title.substring(lastEnd),
        style: const TextStyle(color: Colors.grey),
      ));
    }

    return spans;
  }

  static void openGoogleMaps(Position? position) async {
    if (position != null) {
      final url =
          'https://www.google.com/maps/dir/?api=1&destination=${position.lat},${position.lng}';
      if (await canLaunch(url) != null) {
        await launch(url);
      } else {
        throw 'Could not open the map.';
      }
    }
  }
}
