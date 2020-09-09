import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/custom/watching_widget.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';

class WatchingPage extends StatefulWidget {
  @override
  _WatchingPageState createState() => _WatchingPageState();
}

class _WatchingPageState extends State<WatchingPage> {
  Future<String> getId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("_id");
    return id;
  }

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black,
                      Colors.grey[900],
                      Colors.grey[900],
                      Colors.black,
                    ]),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(4.0, 4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4.0, -4.0),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                ],
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
              ),
              child: Align(
                child: Text(
                  "Watching",
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: _auth.getUserTracker(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return Expanded(
                    flex: 9,
                    child: GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return WatchingWidget(
                          data: snapshot.data[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Expanded(
                    flex: 9,
                    child: Container(
                      child: Center(
                        child: Center(
                          child: Text(
                            "Tracker Empty Add Series from Add Page",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Expanded(
                  flex: 9,
                  child: Container(
                    child: Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
