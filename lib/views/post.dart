import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class PostPage extends StatefulWidget {
  final String title, desc;
  const PostPage({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  Widget postContent(htmlContent) {
    return HtmlWidget(
      htmlContent,
      textStyle: const TextStyle(
          fontFamily: "Raleway",
          fontSize: 16,
          fontWeight: FontWeight.normal), // required, type String
      factoryBuilder: () => FontSizeOverride(),
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
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
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

class FontSizeOverride extends WidgetFactory {
  @override
  void parseStyle(BuildMetadata meta, style) {
    if (style.property == 'font-size') {
      meta.tsb.enqueue((tsh, _) {
        final style = tsh.style.copyWith(fontSize: 16);
        return tsh.copyWith(style: style);
      });
      return;
    }

    super.parseStyle(meta, style);
  }
}
