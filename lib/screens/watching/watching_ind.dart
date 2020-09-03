import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class WatchInd extends StatefulWidget {
  @override
  _WatchIndState createState() => _WatchIndState();
}

class _WatchIndState extends State<WatchInd> {
  Future<dynamic> _getImage(body) async {
    var response = await post(
      "http://192.168.29.72:7000/misc/getimage",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    return base64.decode(json.decode(response.body));
  }

  bool verfiyInc(current, total) {
    if (total == '?') {
      return false;
    }
    if (total == current.toString()) {
      return true;
    } else {
      return false;
    }
  }

  bool verfiyDec(current) {
    if (current == 0) {
      return true;
    }
    return false;
  }

  int current;
  String total;
  Map data;
  var body;

  @override
  Widget build(BuildContext context) {
    data = data == null ? ModalRoute.of(context).settings.arguments : data;
    body = data['data'];
    current = body['current'];
    total = body['total'];
    print(body);
    print(ModalRoute.of(context).settings.arguments);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.grey[800],
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: FutureBuilder(
                  future: _getImage(data["body"]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.memory(
                          snapshot.data,
                          fit: BoxFit.fill,
                        ),
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Form(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Current: ",
                            ),
                            Text(
                              data['data']['current'].toString() + '/',
                            ),
                            Text(
                              data['data']['total'],
                            ),
                            FlatButton(
                              color: Colors.blue,
                              child: Text("+"),
                              onPressed: verfiyInc(current, total)
                                  ? null
                                  : () {
                                      setState(() {
                                        body['current'] += 1;
                                      });
                                    },
                            ),
                            FlatButton(
                              color: Colors.blue,
                              child: Text("-"),
                              onPressed: verfiyDec(current)
                                  ? null
                                  : () {
                                      setState(() {
                                        body['current'] -= 1;
                                      });
                                    },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
