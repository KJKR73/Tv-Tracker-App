import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
                color: Color.fromRGBO(32, 26, 48, 1),
                border: Border(
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              child: Align(
                child: Text(
                  "Watching",
                  style: TextStyle(
                    color: Color.fromRGBO(13, 245, 227, 1),
                    fontFamily: "GM",
                    fontSize: 26,
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
                return Expanded(
                  flex: 8,
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
        ],
      ),
    );
  }
}
