import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';
import 'package:tv_tracker_flutter/shared/constants.dart';

class WatchInd extends StatefulWidget {
  @override
  _WatchIndState createState() => _WatchIndState();
}

class _WatchIndState extends State<WatchInd> {
  bool verfiyInc(current, total) {
    if (total == '?') {
      return false;
    }
    if (int.parse(current) < 0) {
      return true;
    }
    if (int.parse(total) < int.parse(current)) {
      return true;
    } else {
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  int current;
  String total;
  String name;
  Map data;
  var body;
  @override
  Widget build(BuildContext context) {
    data = data == null ? ModalRoute.of(context).settings.arguments : data;
    body = data['data'];
    this.name = body['name'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height - 23,
            width: MediaQuery.of(context).size.width,
            color: primaryColor,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: topDecor(),
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
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
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
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              leading: Container(
                                decoration: topDecor(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 8, 25, 8),
                                  child: Text(
                                    "Name",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: TextFormField(
                                initialValue: body['name'].toString(),
                                validator: (val) =>
                                    val.isEmpty ? "Enter valid name" : null,
                                onChanged: (val) {
                                  setState(() {
                                    this.name = val;
                                  });
                                },
                                decoration: formDecoration().copyWith(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(11, 0, 0, 0),
                                ),
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              trailing: Container(
                                decoration: topDecor(),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "/  " + body["total"],
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              leading: Container(
                                decoration: topDecor(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 8, 17, 8),
                                  child: Text(
                                    "Current",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      decoration: formDecoration().copyWith(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(11, 0, 0, 0),
                                      ),
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      initialValue: body['current'].toString(),
                                      onChanged: (val) {
                                        setState(() {
                                          this.current = int.parse(val);
                                          imageCache.clear();
                                        });
                                      },
                                      validator: (value) {
                                        if (!verfiyInc(value, total)) {
                                          return null;
                                        }
                                        return "Enter a valid ep number";
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                              leading: Container(
                                decoration: topDecor(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(8, 8, 5, 8),
                                  child: Text(
                                    "Total Eps",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              title: TextFormField(
                                keyboardType: TextInputType.number,
                                initialValue: body['total'].toString(),
                                validator: (val) =>
                                    val.isEmpty ? "Enter a valid number" : null,
                                onChanged: (val) {
                                  setState(() {
                                    this.total = val;
                                  });
                                },
                                decoration: formDecoration().copyWith(
                                  contentPadding:
                                      EdgeInsets.fromLTRB(11, 0, 0, 0),
                                ),
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ButtonTheme(
                                minWidth:
                                    MediaQuery.of(context).size.width - 90,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: Colors.orange,
                                  child: Text(
                                    "Update",
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    var id = prefs.getString("_id");
                                    this.name = this.name == null
                                        ? this.body['name']
                                        : name;
                                    this.total = this.total == null
                                        ? this.body['total']
                                        : total;
                                    this.current = this.current == null
                                        ? this.body['current']
                                        : current;
                                    if (_formKey.currentState.validate()) {
                                      Map reqBody = {
                                        "id": id,
                                        "s_id": this.body['_id'],
                                        "name": this.name,
                                        "total": this.total,
                                        "current": this.current,
                                      };
                                      var res =
                                          await _auth.updateTracker(reqBody);
                                      if (this.total.toString() ==
                                          this.current.toString()) {
                                        var compBody = {
                                          "id": id,
                                          "s_id": this.body['_id'],
                                        };
                                        await _auth.addToCompleted(compBody);
                                      }
                                      if (res.statusCode == 200) {
                                        Fluttertoast.showToast(
                                          msg: "Success",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromRGBO(32, 26, 48, 1),
                                          textColor:
                                              Color.fromRGBO(13, 245, 227, 1),
                                          fontSize: 16.0,
                                        );
                                        Navigator.popAndPushNamed(
                                            context, '/home');
                                      } else {
                                        Fluttertoast.showToast(
                                          msg: json.decode(res),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              Color.fromRGBO(32, 26, 48, 1),
                                          textColor: Colors.red,
                                          fontSize: 16.0,
                                        );
                                      }
                                    } else {
                                      print("Error");
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration _decoration() {
  return InputDecoration(
    hintStyle: GoogleFonts.roboto(
      color: Colors.white,
      fontSize: 16,
    ),
    fillColor: Colors.grey[650],
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(11, 0, 0, 0),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
      borderSide: BorderSide(
        color: Colors.white,
        width: 2,
      ),
    ),
  );
}
