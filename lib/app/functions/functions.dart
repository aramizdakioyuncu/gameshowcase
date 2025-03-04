// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Functions {
  static void golink(String url) {
    html.window.location.href = url;
  }
}
