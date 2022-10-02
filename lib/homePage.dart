import 'package:glassmorphism/glassmorphism.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sauce/results.dart';

class homePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var userError;
  var passError;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool obsPass = true;
  @override
  void initState() {
    super.initState();
  }

  void giveError(var errorType, {pass}) {}

  @override
  void dispose() {
    super.dispose();
    userController.dispose();
    passController.dispose();
  }

  Map options = {
    "method": 'GET',
    "headers": {
      'X-RapidAPI-Key': '92ede3d7f8msh9abeca7807637dbp100f96jsnbf69e13717a6',
      'X-RapidAPI-Host': 'anime-db.p.rapidapi.com'
    }
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://i.pinimg.com/564x/eb/25/30/eb25305afba9d332df4497c33bad0f81.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 125, 0, 0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        text: "SAUCE?",
                        style: TextStyle(
                          fontSize: 70,
                          color: Color.fromARGB(255, 255, 125, 168),
                          fontFamily: 'Borsok',
                          fontStyle: FontStyle.normal,
                        ),
                        children: [
                          TextSpan(
                              text: " ",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromRGBO(255, 0, 103, 1),
                              )),
                        ]),
                  ),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 3.5),
                right: 30,
                child: Center(
                  child: GlassmorphicContainer(
                    width: 350,
                    height: 300,
                    borderRadius: 20,
                    blur: 5,
                    alignment: Alignment.center,
                    border: 1,
                    linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFFFFFFF).withOpacity(0.05),
                        ],
                        stops: const [
                          0.1,
                          1,
                        ]),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFffffff).withOpacity(0.5),
                        Color((0xFFFFFFFF)).withOpacity(0.5),
                      ],
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 25),
                            child: TextField(
                                controller: userController,
                                style: const TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.link_rounded),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 5, color: Colors.yellow)),
                                  labelText: "Enter URL",
                                  errorText: userError,
                                ),
                                onChanged: (text) {
                                  containsSpecial(text)
                                      ? giveError("Invalid username")
                                      : giveError(null);
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 255, 125, 168),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            child: const Text(
                              "Search",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              await http
                                  .get(Uri.parse(
                                "https://api.trace.moe/search?anilistInfo&url=${userController.text}",
                              ))
                                  .then((value) async {
                                print(json.decode(value.body));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Result(json.decode(value.body))));
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 30),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 255, 125, 168),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 5),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            child: const Text(
                              "Upload Image",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              await http.get(
                                  Uri.parse(
                                      "https://anime-db.p.rapidapi.com/anime?page=1&size=10&search=naruto%20shippuden&genres=Fantasy%2CDrama&sortBy=ranking&sortOrder=asc"),
                                  headers: {
                                    'X-RapidAPI-Key':
                                        '92ede3d7f8msh9abeca7807637dbp100f96jsnbf69e13717a6',
                                    'X-RapidAPI-Host': 'anime-db.p.rapidapi.com'
                                  }).then(
                                  (value1) => print(json.decode(value1.body)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  bool containsSpecial(String value) {
    //var dumdum = new RegExp(r'[$#]');

    Set<String> chars = {
      " ",
      "!",
      "%",
      "&",
      "'",
      "(",
      ")",
      "*",
      "+",
      "-",
      "/",
      ":",
      ";",
      "<",
      "=",
      ">",
      "?",
      "@",
      "[",
      "\\",
      "]",
      "^",
      '`',
      "{",
      "|",
      "}",
      "~"
    };
    bool rvalue = false;
    for (int i = 0; i < value.length; i++) {
      if (chars.contains(value[i])) {
        rvalue = true;
        break;
      }
    }
    return rvalue;
  }
}
