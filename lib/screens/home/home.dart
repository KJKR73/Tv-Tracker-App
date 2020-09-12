import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tv_tracker_flutter/screens/add/add_main.dart';
import 'package:tv_tracker_flutter/screens/completed/completed_main.dart';
import 'package:tv_tracker_flutter/screens/dropped/dropped_main.dart';
import 'package:tv_tracker_flutter/screens/home/home_widget.dart';
import 'package:tv_tracker_flutter/screens/watching/watching_main.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controller = TextEditingController();
  dynamic user;
  var test;
  var _currentIndex = 0;
  // Future<void> getData() async {
  //   var response = await get(
  //     'http://192.168.29.72:7000/api/test/',
  //     headers: {
  //       "Authorization":
  //           "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI1ZjNmNmY4YTYyNjQ1MzI0ZjAyYzVlYWEiLCJpYXQiOjE1OTgxOTYzNjcyODEsImV4cCI6MTU5ODE5NjQ1MzY4MX0._HoXbosMj4GoiWECS_cTuG0696q9fGh4ALnkmGWE9tI"
  //     },
  //   );
  //   setState(() {
  //     this.user = json.decode(response.body);
  //   });
  // }

  // Future<void> getData1() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   var ans = pref.getString("token");
  //   setState(() {
  //     this.test = ans;
  //   });
  // }

  Future<dynamic> initData() async {
    var response = await get("http://192.168.29.72:7000/series/getall");
    return json.decode(response.body);
  }

  Future<void> removeDataLocal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(9, 12, 28, 1),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: primaryColor,
          ),
          child: Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  child: Container(
                    decoration: topDecor(),
                    child: Center(
                      child: Text(
                        "TTracker",
                        style: GoogleFonts.oswald(
                          fontSize: 66,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await removeDataLocal();
                    Navigator.popAndPushNamed(context, '/authenticate');
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.all_out,
                      color: Colors.orange,
                      size: 34,
                    ),
                    title: Text(
                      "Logout",
                      style: GoogleFonts.roboto(
                        color: Colors.orange,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 300,
                ),
                Container(
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "About",
                          style: GoogleFonts.roboto(
                            color: Colors.orange,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Author Name : Karanjot Singh",
                          style: GoogleFonts.roboto(
                            color: Colors.orange,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          "App Not for Sale",
                          style: GoogleFonts.roboto(
                            color: Colors.red,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromRGBO(20, 24, 43, 1),
          currentIndex: _currentIndex,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.white24,
          items: [
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              title: Text("Watching"),
              icon: Icon(
                Icons.grid_on,
              ),
            ),
            BottomNavigationBarItem(
              title: Text("Dropped"),
              icon: Icon(
                Icons.arrow_downward,
              ),
            ),
            BottomNavigationBarItem(
              title: Text("Completed"),
              icon: Icon(
                Icons.star,
              ),
            ),
            BottomNavigationBarItem(
              title: Text("Add"),
              icon: Icon(
                Icons.add,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: _load(_currentIndex),
      ),
    );
  }

  Widget _load(var index) {
    if (index == 0) {
      return HomeWidget();
    } else if (index == 1) {
      return WatchingPage();
    } else if (index == 2) {
      return DroppedPage();
    } else if (index == 3) {
      return CompletedPage();
    } else {
      return FutureBuilder(
        future: initData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return AddPage(
              height: MediaQuery.of(context).size.height - 80,
              width: MediaQuery.of(context).size.width,
              data: snapshot.data,
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
      );
    }
  }
}
