import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:tv_tracker_flutter/custom/add_widget.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';

class AddPage extends StatefulWidget {
  dynamic data;
  dynamic height;
  dynamic width;
  AddPage({this.height, this.width, this.data});
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  Future<void> _queryDataLoader(queryObj) async {
    var response = await post(
      "http://192.168.29.72:7000/series/search",
      body: json.encode(queryObj),
      headers: {"Content-Type": "application/json"},
    );
    setState(() {
      queryData = json.decode(response.body);
    });
  }

  var _controller;
  // var _scrollController;

  void initState() {
    super.initState();
    _controller = TextEditingController();
    // _scrollController = ScrollController();
  }

  AuthService _auth = AuthService();
  dynamic queryData;
  @override
  Widget build(BuildContext context) {
    _onTextChanged(String text) async {
      var queryObj = {"query": text};
      await _queryDataLoader(queryObj);
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          height: widget.height,
          width: widget.width,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.black,
                  padding: EdgeInsets.fromLTRB(2, 2, 2, 1),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            queryData = null;
                          });
                        },
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                      ),
                      title: TextField(
                        onChanged: _onTextChanged,
                        controller: _controller,
                        decoration: InputDecoration(
                          fillColor: Colors.red,
                          border: InputBorder.none,
                          hintText: "Search Series",
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 18,
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
                  child: queryData == null
                      ? ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2.0,
                              child: Container(
                                color: Colors.grey[600],
                              ),
                            );
                          },
                          itemCount: widget.data.length,
                          itemBuilder: (context, index) {
                            return AddWidget(
                              name: widget.data[index]["name"],
                              image64: widget.data[index]["cover"],
                              total: widget.data[index]["total"],
                              season: widget.data[index]["season"],
                              id: widget.data[index]["_id"],
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 2.0,
                              child: Container(
                                color: Colors.grey[600],
                              ),
                            );
                          },
                          itemCount: queryData.length,
                          itemBuilder: (context, index) {
                            return AddWidget(
                              name: queryData[index]["name"],
                              image64: queryData[index]["cover"],
                              total: queryData[index]["total"],
                              season: queryData[index]["season"],
                            );
                          },
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
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
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            color: Color.fromRGBO(13, 245, 227, 1),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.popAndPushNamed(context, '/addnew');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
