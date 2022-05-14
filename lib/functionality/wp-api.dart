// ignore_for_file: file_names
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var unescape = HtmlUnescape();

Future<List> fetchWpPosts(page, limit, category) async {
  //var url = Uri.https('muslimgap.com', '/wp-json/wp/v2/posts',
  //{'Accept': 'application/json', 'page': page, 'per_page': limit});
  var url = Uri.parse(
      'https://muslimgap.com/wp-json/wp/v2/posts?page=$page&per_page=$limit&categories=$category');

  final response = await http.get(url, headers: {'Accept': 'application/json'});

  var convertDataToJson =
      jsonDecode(unescape.convert(response.body.replaceAll('&quot;', '\'')));

  if (convertDataToJson[0] == null) {
    return List.empty();
  }

  return convertDataToJson;
}

Future fetchWpPostImageUrl(href) async {
  if (href == null) return null;

  var url = Uri.parse(href);
  final response = await http.get(url, headers: {'Accept': 'application/json'});

  var convertDataToJson = jsonDecode(unescape.convert(response.body));

  return convertDataToJson;
}
