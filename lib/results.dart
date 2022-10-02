import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:sauce/homePage.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  //  final String name;
  //  final String imgURL;
  //  final String episode;
  //  final String startTime;
  //  final String EndTime;
  final Map data;
  Result(this.data);
  ResultState createState() => ResultState();
}

class ResultState extends State<Result> {
  late VideoPlayerController _controller;
  String text = "";
  int _currentIndex = 0;
  var recs;
  var cntlr = TextEditingController();

  Future<void> getRecs() async {
    await http.get(
        Uri.parse(
            "https://anime-db.p.rapidapi.com/anime?page=1&size=10&search=naruto%20shippuden&genres=Fantasy%2CDrama&sortBy=ranking&sortOrder=asc"),
        headers: {
          'X-RapidAPI-Key':
              '92ede3d7f8msh9abeca7807637dbp100f96jsnbf69e13717a6',
          'X-RapidAPI-Host': 'anime-db.p.rapidapi.com'
        }).then((value1) {
      setState(() => recs = value1.body);
      print(recs);
    });
    print(recs);
  }

  @override
  void initState() {
    super.initState();
    print(widget.data);
    getRecs();
    _controller = VideoPlayerController.network(
        "https://media.trace.moe/video/21519/%5BReinForce%5D%20Kimi%20no%20Na%20wa.%20(BDRip%201920x1080%20x264%20FLAC).mp4?t=2033.835&now=1664679600&token=C0FTmUBpWjvVAP3oji92mYtDE")
      ..initialize().then((_) {
        print("initialized");
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    cntlr.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: const Text(
          "Sauce.",
          style: TextStyle(
            fontFamily: "Borsok",
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              "https://i.pinimg.com/564x/eb/25/30/eb25305afba9d332df4497c33bad0f81.jpg",
              fit: BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.network(
                        widget.data["result"][0]["image"].toString(),
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Text(
                      widget.data["result"][0]["anilist"]["title"]["english"]
                          .toString(),
                      style: TextStyle(
                          fontSize: 45,
                          color: const Color.fromARGB(255, 255, 125, 168)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 20, 30),
                    child: Text(
                      widget.data["result"][0]["anilist"]["title"]["native"]
                          .toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 125, 168)),
                    ),
                  ),
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                    margin: EdgeInsets.fromLTRB(
                        (5 * MediaQuery.of(context).size.height) / 100,
                        0,
                        (5 * MediaQuery.of(context).size.height) / 100,
                        0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                            child: widget.data["result"][0]["episode"] != null
                                ? Text(
                                    "Episode : ${widget.data["result"][0]["episode"]}",
                                    style: const TextStyle(fontSize: 19),
                                  )
                                : const Text(
                                    "Episode : Movie",
                                    style: TextStyle(fontSize: 19),
                                  ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
                            child: Text(
                              "Timestamp: ${widget.data["result"][0]["from"]}  to  ${widget.data["result"][0]["to"]}s",
                              style: const TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 5, 25, 20),
                            child: Text(
                              "Simlarity : " +
                                  (widget.data["result"][0]["similarity"] * 100)
                                      .toInt()
                                      .toString() +
                                  "%",
                              style: const TextStyle(fontSize: 19),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );

    /*Positioned(
            top: (MediaQuery.of(context).size.height / 4) - 30,
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 15,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                Radius.circular(20),
              )),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Image.network(
                        widget.data["result"][0]["image"].toString(),
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / 100
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Text(
                        widget.data["result"][0]["anilist"]["title"]["english"]
                            .toString(),
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
                      child: Text(
                        widget.data["result"][0]["anilist"]["title"]["native"]
                            .toString(),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(78, 74, 74, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                          ),
                          child: const Text(
                            "More Info",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homePage()));
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(148, 148, 148, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                          ),
                          child: const Text(
                            "Search Again",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => homePage()));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),*/
  }
}
