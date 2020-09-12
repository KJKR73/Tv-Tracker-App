import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';
import 'package:tv_tracker_flutter/shared/pie_charts.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String _username;
  Future<dynamic> _getPieData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/misc/getPieData",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  Future<dynamic> _getUserImage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/user/getImage",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return response;
  }

  Future<dynamic> _getHomeInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/misc/getHomeInfo",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  Future<dynamic> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    var response = await post(
      "http://192.168.29.72:7000/user/getUsername",
      body: json.encode({
        "id": id,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return json.decode(response.body);
  }

  final imagePicker = ImagePicker();
  Future _collectImage() async {
    try {
      dynamic userImage = await imagePicker.getImage(
        source: ImageSource.gallery,
        maxHeight: 256,
        maxWidth: 256,
      );
      final imageBytes = io.File(userImage.path).readAsBytesSync();
      SharedPreferences pref = await SharedPreferences.getInstance();
      var id = pref.getString("_id");
      Map body = {
        "id": id,
        "image": base64.encode(imageBytes),
      };
      await post(
        "http://192.168.29.72:7000/user/saveImage",
        body: json.encode(body),
        headers: {"Content-Type": "application/json"},
      );
      setState(() {});
    } catch (e) {
      setState(() {});
    }
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[Colors.pink, Colors.orange],
  ).createShader(
    Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
  );

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 130,
                color: primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Text(
                                  "TTracker",
                                  style: GoogleFonts.oswald(
                                    fontSize: 72,
                                    fontWeight: FontWeight.bold,
                                    foreground: Paint()
                                      ..shader = linearGradient,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: FutureBuilder(
                                future: getUsername(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Welcome " + snapshot.data.toString(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.orange,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        "Welcome",
                                        style: GoogleFonts.roboto(
                                          color: Colors.orange,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: FutureBuilder(
                        future: _getUserImage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  color: Colors.orange,
                                  child: Image.memory(
                                    base64.decode(
                                      json.decode(snapshot.data.body),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () async {
                                _collectImage();
                              },
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Container(
                                    color: Colors.orange,
                                    child: Image.asset("assets/user.png"),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                height: 50,
                child: Text(
                  "Summary",
                  style: GoogleFonts.roboto(
                    color: Colors.pink,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FutureBuilder(
                future: _getHomeInfo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 250,
                      color: primaryColor,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.list,
                                    size: 30,
                                    color: secondaryColor,
                                  ),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          "Total Series",
                                          style: GoogleFonts.roboto(
                                            color: secondaryColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          snapshot.data[3]["len"].toString(),
                                          style: GoogleFonts.roboto(
                                            color: secondaryColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.stay_current_landscape,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Watching",
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data[0]["len"].toString(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.done,
                                  size: 30,
                                  color: Colors.blue[400],
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Compeleted",
                                        style: GoogleFonts.roboto(
                                          color: Colors.blue[400],
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data[2]["len"].toString(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.blue[400],
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: ListTile(
                                leading: Icon(
                                  Icons.arrow_drop_down_circle,
                                  size: 30,
                                  color: Colors.green,
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Dropped",
                                        style: GoogleFonts.roboto(
                                          color: Colors.green,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        snapshot.data[1]["len"].toString(),
                                        style: GoogleFonts.roboto(
                                          color: Colors.green,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: 250,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    );
                  }
                },
              ),
              FutureBuilder(
                future: _getPieData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 400,
                      child: CreatePie(
                        data: snapshot.data,
                        animate: true,
                      ),
                    );
                  } else {
                    return Container(
                      height: 500,
                    );
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
