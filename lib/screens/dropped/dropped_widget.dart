import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class DroppedWidget extends StatefulWidget {
  dynamic data;
  DroppedWidget({this.data});
  @override
  _DroppedWidgetState createState() => _DroppedWidgetState();
}

class _DroppedWidgetState extends State<DroppedWidget> {
  Future<dynamic> _getImage(body) async {
    var response = await post(
      "http://192.168.29.72:7000/misc/getimage",
      body: json.encode(body),
      headers: {"Content-Type": "application/json"},
    );
    return base64.decode(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Map body = {"series_id": widget.data["_id"]};
    return GestureDetector(
      onTap: () async {
        var image64 = await _getImage(body);
        Navigator.pushNamed(context, '/dropped_info', arguments: {
          "body": body,
          "data": widget.data,
          "image64": image64,
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: FutureBuilder(
                future: _getImage(body),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image.memory(
                                snapshot.data,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 1, 2, 2),
                                    child: RaisedButton(
                                      color: Colors.white,
                                      child: Text('Re-Add to Watching'),
                                      onPressed: () async {
                                        // SharedPreferences pref =
                                        //     await SharedPreferences
                                        //         .getInstance();
                                        // var id = pref.getString("_id");
                                        // Map body = {
                                        //   "id": id,
                                        //   "s_id": widget.data["_id"]
                                        // };
                                        // var response =
                                        //     await _auth.dropSeries(body);

                                        // if (response.statusCode == 200 &&
                                        //     response.body == "success") {
                                        //   Fluttertoast.showToast(
                                        //     msg: "Success",
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.CENTER,
                                        //     timeInSecForIosWeb: 1,
                                        //     backgroundColor:
                                        //         Color.fromRGBO(32, 26, 48, 1),
                                        //     textColor:
                                        //         Color.fromRGBO(13, 245, 227, 1),
                                        //     fontSize: 16.0,
                                        //   );
                                        //   Navigator.popAndPushNamed(
                                        //       context, "/home");
                                        // } else {
                                        //   Fluttertoast.showToast(
                                        //     msg: response.body,
                                        //     toastLength: Toast.LENGTH_SHORT,
                                        //     gravity: ToastGravity.CENTER,
                                        //     timeInSecForIosWeb: 2,
                                        //     backgroundColor: Colors.red,
                                        //     textColor: Colors.black,
                                        //     fontSize: 16.0,
                                        //   );
                                        // }
                                        // Navigator.popAndPushNamed(
                                        //     context, "/home");
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    width: 1,
                    color: Colors.white,
                  ),
                  color: Color.fromRGBO(24, 24, 24, 1),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.data["name"],
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
