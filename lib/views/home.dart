import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muslim_gap_app/functionality/wp-api.dart';
import 'package:muslim_gap_app/functionality/postTile.dart';
import 'package:flutter/services.dart' as serv;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _page = 1; // Get multiple pages of API request

  final int _limit = 100; // Set how many posts per page
  final int _stories = 2; // Category for story posts
  final int _challenges = 4;
  int _category = 2;
  // There is next page or not
  bool _hasNextPage = true;
  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  // This holds the posts fetched from the server
  final List<dynamic> _posts = [];
  final List<dynamic> _challs = [];
  final List<dynamic> _story = [];

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    htmlText = htmlText.replaceAll(exp, '');
    return htmlText;
  }

  String cleanDescription(String htmlText) {
    int idx = htmlText.indexOf(
        '<div class="psac-post-carousel-wrp psac-slider-and-carousel psac-clearfix">');
    if (idx != -1) {
      htmlText = htmlText.substring(0, idx);
    }
    htmlText = htmlText.replaceAll(
        RegExp(r'<a href=".*">', multiLine: true, caseSensitive: true), "");
    htmlText = htmlText.replaceAll(
        RegExp(r"<\/a>", multiLine: true, caseSensitive: true), "");
    htmlText = htmlText.replaceAll(
        RegExp(r'<label.*>Email<\/label>',
            multiLine: true, caseSensitive: true),
        "");
    return htmlText;
  }

  void fetch() async {
    final fetchedPosts = await fetchWpPosts(_page, _limit, _category);
    if (fetchedPosts.isNotEmpty) {
      setState(() {
        if (_category == _stories) {
          _story.addAll(fetchedPosts);
        } else if (_category == _challenges) {
          _challs.addAll(fetchedPosts);
        }
      });
    } else {
      // This means there is no more data
      // and therefore, we will not send another GET request
      setState(() {
        _isLoadMoreRunning = false;
        _hasNextPage = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                const Text('All Posts Loaded!', textAlign: TextAlign.center),
            duration: const Duration(milliseconds: 2500),
            width: 200.0, // Width of the SnackBar.
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0, // Inner padding for SnackBar content.
            ),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        );
      });
    }
  }

  int _selectedIndex = 0;
  bool _tapped = false;
  void _onItemTapped(int index) {
    //Reset list to item 0
    _controller.animateTo(0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
    _selectedIndex = index;
    if (_selectedIndex == 1) {
      //setState(() {
      _category = _challenges;
      //});
    } else {
      //setState(() {
      _category = _stories;
      //});
    }
    //Clear posts and change lists
    setState(() {
      _posts.clear();
      _tapped = true;
      //_isLoadMoreRunning = true;
    });
    //imageCache!.clearLiveImages();
    imageCache!.clear();
    setState(() {
      if (_category == _challenges) {
        _posts.addAll(_challs);
      } else {
        _posts.addAll(_story);
      }
      _tapped = false;
      //_isLoadMoreRunning = false;
    });
  }

// This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await fetchWpPosts(_page, _limit, _stories);
      final res2 = await fetchWpPosts(_page, _limit, _challenges);

      setState(() {
        _story.addAll(res);
        _challs.addAll(res2);
        _posts.addAll(_story);
        _isFirstLoadRunning = false;
      });
    } catch (err) {
      print(err);
    }
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 5) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });

      _page += 1; // Increase _page by 1

      try {
        if (_selectedIndex == 1) {
          _category = _challenges;
        } else {
          _category = _stories;
        }
        // Send Get request
        fetch();
      } catch (err) {
        print(err);
      }
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 29, 31),
      appBar: AppBar(
        title: const Text(
          "MuslimGap",
          style: TextStyle(fontFamily: "Raleway"),
        ),
      ),
      body: _isFirstLoadRunning
          ? Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "MuslimGap",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Quick Reads To Brighten Your Day!",
                      style: TextStyle(
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.normal,
                          fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ]),
            )
          : Column(children: [
              Expanded(
                child: ListView.builder(
                    key: ObjectKey(_posts[0]),
                    controller: _controller,
                    itemCount: _posts.length,
                    cacheExtent: 9999,
                    itemBuilder: (BuildContext context, int index) {
                      Map wppost = _posts[index];
                      String description = wppost['content']['rendered'];

                      description = cleanDescription(description);

                      imageCache!.clear();
                      imageCache!.clearLiveImages();

                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 5, left: 5, top: 10, bottom: 10),
                        child: PostTile(
                          imageApiUrl: wppost['_links']["wp:featuredmedia"][0]
                              ["href"],
                          excerpt: removeAllHtmlTags(
                                          wppost['excerpt']['rendered'])
                                      .length >
                                  200
                              ? removeAllHtmlTags(wppost['excerpt']['rendered'])
                                      .substring(0, 200) +
                                  "... \nRead More »"
                              : removeAllHtmlTags(
                                  wppost['excerpt']['rendered']),
                          desc: description,
                          title: wppost['title']['rendered'],
                        ),
                      );
                    }),
              ),
              if (_isLoadMoreRunning == true)
                const Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Center(
                    child: LinearProgressIndicator(),
                  ),
                ),
              // when the _loadMore function is running
            ]),
      bottomNavigationBar: _isFirstLoadRunning
          ? null
          : BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  label: 'Stories',
                  icon: Icon(Icons.auto_stories_rounded),
                ),
                BottomNavigationBarItem(
                  label: 'Challenge of the Day',
                  icon: Icon(Icons.assignment_rounded),
                ),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            ),
    );
  }
}
