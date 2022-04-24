import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostPage extends StatefulWidget {
  final String imageUrl, title, desc;
  const PostPage(
      {Key? key,
      required this.title,
      required this.desc,
      required this.imageUrl})
      : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Widget postContent(htmlContent) {
    return HtmlWidget(
      htmlContent, // required, type String
      //onErrorBuilder: (context, element, error) =>
      //Text('$element error: $error'),
      //Container(),
    );
    //onLoadingBuilder: (context, element, loadingProgress) =>
    //const CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //     child: widget.imageUrl != ""
              //         ? Image.network(widget.imageUrl)
              //         : Container()),
              const SizedBox(height: 8),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 6),
              postContent(
                widget.desc,
              )
            ],
          ),
        ),
      ),
    );
  }
}
