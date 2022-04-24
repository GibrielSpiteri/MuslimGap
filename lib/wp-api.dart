// ignore_for_file: file_names
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var unescape = HtmlUnescape();

Future<List> fetchWpPosts() async {
  var url = Uri.https(
      'muslimgap.com', '/wp-json/wp/v2/posts', {'Accept': 'application/json'});

  final response = await http.get(url);

  List<dynamic> convertDataToJson = jsonDecode(unescape.convert(response.body));
  return convertDataToJson;
}

Future fetchWpPostImageUrl(href) async {
  var url = Uri.parse(href);
  final response = await http.get(url, headers: {'Accept': 'application/json'});

  var convertDataToJson = jsonDecode(unescape.convert(response.body));
  return convertDataToJson;
}
