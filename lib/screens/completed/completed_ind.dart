import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';
import 'package:intl/intl.dart';

class CompletedInd extends StatefulWidget {
  @override
  _CompletedIndState createState() => _CompletedIndState();
}

class _CompletedIndState extends State<CompletedInd> {
  final AuthService _auth = AuthService();
  int current;
  String total;
  String name;
  Map data;
  var body;
  var months = [
    "Jan",
    "Feb",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  @override
  Widget build(BuildContext context) {
    data = data == null ? ModalRoute.of(context).settings.arguments : data;
    body = data['data'];
    this.name = body['name'];
    var dateSlices = body['date'].toString().substring(0, 10).split("-");
    var date = int.parse(dateSlices[2]);
    var month = months[int.parse(dateSlices[1]) - 1];
    var year = int.parse(dateSlices[0]);
    var displayDate = month + " " + date.toString() + ", " + year.toString();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 23,
            width: MediaQuery.of(context).size.width,
            color: Color.fromRGBO(24, 24, 24, 1),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black,
                            Colors.grey[900],
                            Colors.grey[900],
                            Colors.black,
                          ]),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Center(
                            child: Text(
                              body['name'],
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.0,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width - 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(
                        data['image64'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 25, 8),
                                child: Text(
                                  "Season",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              "1",
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 17, 8),
                                child: Text(
                                  "Total Episodes",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              body['total'],
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 8, 5, 8),
                                child: Text(
                                  "Completed On",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              displayDate,
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                          flex: 2,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
