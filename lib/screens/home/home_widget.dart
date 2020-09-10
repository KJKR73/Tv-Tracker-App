import 'dart:convert';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';
import 'package:tv_tracker_flutter/shared/pie_charts.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              color: primaryColor,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(
                        "Welcome Karanjot",
                        style: GoogleFonts.roboto(
                          color: secondaryColor,
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 400,
              color: primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Series Watched",
                    style: GoogleFonts.roboto(
                      color: secondaryColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Total Series Dropped",
                    style: GoogleFonts.roboto(
                      color: secondaryColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: _getPieData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 600,
                    child: CreatePie(
                      data: snapshot.data,
                      animate: true,
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Container(
              height: 400,
              color: primaryColor,
            ),
          ]),
        )
      ],
    );
  }
}
