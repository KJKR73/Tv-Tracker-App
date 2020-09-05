import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';

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
    if (int.parse(current) < 0) {
      return true;
    }
    if (int.parse(total) < int.parse(current)) {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  int current;
  String total;
  Map data;
  var body;
  @override
  Widget build(BuildContext context) {
    data = data == null ? ModalRoute.of(context).settings.arguments : data;
    body = data['data'];
    total = body['total'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Colors.grey[850],
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: FutureBuilder(
                  future: _getImage(data["body"]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: MediaQuery.of(context).size.width - 80,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "Update Info",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                        ListTile(
                          title: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(
                                  "Current: ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "GM",
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    initialValue: body['current'].toString(),
                                    onChanged: (val) {
                                      setState(() {
                                        this.current = int.parse(val);
                                        imageCache.clear();
                                      });
                                    },
                                    validator: (value) {
                                      if (!verfiyInc(value, total)) {
                                        return null;
                                      }
                                      return "NV";
                                    },
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '/',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "GM",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  total,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "GM",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    print(current);
                                  }
                                },
                              )
                            ],
                          ),
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

// Expanded(
//   flex: 1,
//   child: FlatButton(
//     color: Colors.blue,
//     child: Icon(Icons.add),
//     onPressed: verfiyInc(current, total)
//         ? null
//         : () {
//             setState(() {
//               body['current'] += 1;
//             });
//           },
//   ),
// ),
// Expanded(
//   flex: 1,
//   child: Text(
//     data['data']['current'].toString() + '/',
//     style: TextStyle(
//       color: Colors.white,
//       fontFamily: "GM",
//       fontSize: 16,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
// Expanded(
//   flex: 1,
//   child: Text(
//     data['data']['total'],
//     style: TextStyle(
//       color: Colors.white,
//       fontFamily: "GM",
//       fontSize: 16,
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// ),
// Expanded(
//   flex: 1,
//   child: FlatButton(
//     color: Colors.blue,
//     child: Icon(Icons.subway),
//     onPressed: verfiyDec(current)
//         ? null
//         : () {
//             setState(() {
//               body['current'] -= 1;
//             });
//           },
//   ),
// ),
