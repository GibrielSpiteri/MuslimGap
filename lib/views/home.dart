import 'package:flutter/material.dart';
import 'package:muslim_gap_app/views/post.dart';
import 'package:muslim_gap_app/wp-api.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MuslimGap"),
      ),
      body: FutureBuilder(
        future: fetchWpPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                cacheExtent: 9999,
                itemBuilder: (BuildContext context, int index) {
                  Map wppost = snapshot.data[index];
                  return PostTile(
                      imageApiUrl: wppost['_links']["wp:featuredmedia"][0]
                          ["href"],
                      excerpt: removeAllHtmlTags(wppost['excerpt']['rendered']),
                      desc: wppost['content']['rendered'],
                      title: wppost['title']['rendered']);
                });
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class PostTile extends StatefulWidget {
  final String imageApiUrl, title, desc, excerpt;
  const PostTile(
      {Key? key,
      required this.imageApiUrl,
      required this.title,
      required this.desc,
      required this.excerpt})
      : super(key: key);

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPage(
              title: widget.title,
              imageUrl: imageUrl,
              desc: widget.desc,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: fetchWpPostImageUrl(widget.imageApiUrl),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    imageUrl = snapshot.data["guid"]["rendered"];
                    return SizedBox(
                      child: Center(
                        child: CachedNetworkImage(
                          imageUrl: imageUrl,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      height: 100,
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
            const SizedBox(height: 8),
            Text(
              widget.title,
              style: const TextStyle(fontFamily: "Raleway", fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(widget.excerpt, style: const TextStyle(fontFamily: "Raleway"))
          ],
        ),
      ),
    );
  }
}
