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

  @override
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
                right: 15,
                top: (MediaQuery.of(context).size.height / 10) - 5,
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
                            text: "?",
                            style: TextStyle(
                              color: Color.fromRGBO(66, 66, 66, 1),
                            ))
                      ]),
                ),
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height / 4) + 25,
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
                            primary: const Color.fromRGBO(148, 148, 148, 1),
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
                                    "https://api.trace.moe/search?anilistInfo&url=${userController.text}"))
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
                            primary: const Color.fromRGBO(148, 148, 148, 1),
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
                            await http
                                .get(Uri.parse(
                                    "https://api.trace.moe/search?anilistInfo&url=https://images.plurk.com/32B15UXxymfSMwKGTObY5e.jpg"))
                                .then(
                                    (value) => print(json.decode(value.body)));
                          },
                        ),
                      ),
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
