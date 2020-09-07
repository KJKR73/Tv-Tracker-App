import 'dart:convert';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class AddWidget extends StatelessWidget {
  String image64;
  String total;
  String name;
  String season;
  dynamic id;
  AddWidget({this.image64, this.total, this.name, this.season, this.id});
  @override
  Widget build(BuildContext context) {
    Future<dynamic> addSeriesTracker(body) async {
      var response = await post(
        "http://192.168.29.72:7000/tracker/watching/addNewSeries",
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );
      return response.body;
    }

    var image = base64.decode(this.image64);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/add_info', arguments: {
          "total": this.total,
          "image64": image,
          "name": this.name,
          "id": this.id,
          "season": this.season,
        });
      },
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.fromLTRB(3, 5, 3, 5),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 200,
                child: ClipRRect(
                  child: Image.memory(
                    image,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 200,
                color: Colors.grey[900],
                child: Padding(
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          name,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "GM",
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Episodes : " + total,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "GM",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Season: " + season,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "GM",
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: ButtonTheme(
                          minWidth: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            color: Color.fromRGBO(13, 245, 227, 1),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "GM",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              var userId = pref.getString("_id");
                              Map body = {
                                "id": userId,
                                "s_id": id,
                              };
                              var response = await addSeriesTracker(body);
                              print(response);
                              if (response == "success") {
                                Fluttertoast.showToast(
                                  msg: "Success",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromRGBO(32, 26, 48, 1),
                                  textColor: Color.fromRGBO(13, 245, 227, 1),
                                  fontSize: 16.0,
                                );
                              } else {
                                Fluttertoast.showToast(
                                  msg: response,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.black,
                                  fontSize: 16.0,
                                );
                              }
                            },
                          ),
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
    );
  }
}
