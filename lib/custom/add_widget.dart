import 'dart:convert';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';

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
        color: primaryColor,
        padding: EdgeInsets.fromLTRB(0, 2, 8, 2),
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
                color: primaryColor,
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
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Episodes : " + total,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Season : " + season,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 17,
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
                              "Add To Tracker",
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 16,
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
