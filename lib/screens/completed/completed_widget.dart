import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

// ignore: must_be_immutable
class CompletedWidget extends StatefulWidget {
  dynamic data;
  CompletedWidget({this.data});
  @override
  _CompletedWidgetState createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
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
        Navigator.pushNamed(context, '/completed_info', arguments: {
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
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.memory(
                          snapshot.data,
                          fit: BoxFit.fill,
                        ),
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
