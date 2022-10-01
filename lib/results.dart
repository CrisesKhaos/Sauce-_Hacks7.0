import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sauce/homePage.dart';

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
  String text = "";
  int _currentIndex = 0;
  var cntlr = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.data);
  }

  @override
  void dispose() {
    super.dispose();
    cntlr.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 100,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: 8.5 * MediaQuery.of(context).size.width / 10,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(66, 66, 66, 1))),
              Positioned(
                right: 43,
                top: (MediaQuery.of(context).size.height / 10) - 60,
                child: RichText(
                  text: const TextSpan(
                      text: "sauce",
                      style: TextStyle(
                        fontSize: 70,
                        color: Colors.white,
                        fontFamily: 'Vonique',
                        fontStyle: FontStyle.normal,
                      ),
                      children: [
                        TextSpan(
                            text: "  ",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(255, 0, 103, 1),
                            )),
                        TextSpan(
                            text: ".",
                            style: TextStyle(
                              color: Color.fromRGBO(66, 66, 66, 1),
                              fontSize: 100,
                            ))
                      ]),
                ),
              ),
              Positioned(
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
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          100
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
                            widget.data["result"][0]["anilist"]["title"]
                                    ["english"]
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
                            widget.data["result"][0]["anilist"]["title"]
                                    ["native"]
                                .toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 20, 5),
                          child: widget.data["result"][0]["episode"] != null
                              ? Text(
                                  "Episode : " +
                                      widget.data["result"][0]["episode"]
                                          .toString(),
                                  style: TextStyle(fontSize: 19),
                                )
                              : Text(
                                  "Episode : Movie",
                                  style: TextStyle(fontSize: 19),
                                ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(50, 5, 20, 20),
                          child: Text(
                            "Timestamp: " +
                                widget.data["result"][0]["from"].toString() +
                                "  to  " +
                                widget.data["result"][0]["to"].toString() +
                                "s",
                            style: TextStyle(fontSize: 19),
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
