import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/customWidgets/add_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  Widget add(var height, var width, var data) {
    return Container(
      height: height,
      width: width,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Card(
                child: ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      setState(() {
                        initData();
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                  title: TextField(
                    onChanged: null,
                    decoration: InputDecoration(
                      fillColor: Colors.red,
                      border: InputBorder.none,
                      hintText: "Search Series",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return AddWidget(
                      name: data[index]["name"],
                      image64: data[index]["cover"],
                      total: data[index]["total"],
                      season: data[index]["season"],
                    );
                  },
                )),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Color.fromRGBO(32, 26, 48, 1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        "Don't see you series add it here",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton(
                        color: Color.fromRGBO(13, 245, 227, 1),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
    return Scaffold(
      backgroundColor: Color.fromRGBO(24, 24, 24, 1),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(24, 24, 24, 1),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
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
      body: _currentIndex == 4
          ? FutureBuilder(
              future: initData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return add(MediaQuery.of(context).size.height - 80,
                      MediaQuery.of(context).size.width, snapshot.data);
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
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "HOME",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      RaisedButton(
                        onPressed: () async {
                          await removeDataLocal();
                          Navigator.popAndPushNamed(context, '/authenticate');
                        },
                        child: Text(
                          "LOGOUT",
                          style: TextStyle(
                            color: Colors.white,
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

// add(MediaQuery.of(context).size.height - 80,
//               MediaQuery.of(context).size.width)
