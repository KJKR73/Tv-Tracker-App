import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';

class AddNew extends StatefulWidget {
  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  final imagePicker = ImagePicker();
  final _formkey = GlobalKey<FormState>();
  dynamic _imageDisplay;
  dynamic _image64;
  String seriesName;
  String totalEps = "?";
  String season = "1";
  String err;
  final AuthService _auth = new AuthService();
  Future _collectImage() async {
    try {
      dynamic userImage = await imagePicker.getImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 600,
      );
      final imageBytes = io.File(userImage.path).readAsBytesSync();
      setState(() {
        _imageDisplay = imageBytes;
        _image64 = base64.encode(imageBytes);
      });
    } catch (e) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            color: Color.fromRGBO(32, 32, 32, 1),
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Color.fromRGBO(32, 32, 32, 1),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: _imageDisplay == null
                              ? Container(
                                  height: 400,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: Center(
                                    child: InkWell(
                                      child: Text(
                                        "Tap on text to add image",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      onTap: () async {
                                        await _collectImage();
                                      },
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () async {
                                    await _collectImage();
                                  },
                                  child: Container(
                                    height: 400,
                                    width: 200,
                                    child: Image.memory(
                                      _imageDisplay,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color.fromRGBO(32, 32, 32, 1),
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  this.seriesName = val;
                                });
                              },
                              validator: (value) =>
                                  value.isEmpty ? "Enter Valid Name" : null,
                              decoration: _decoration().copyWith(
                                hintText: "Name",
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  this.totalEps = val;
                                });
                              },
                              validator: (value) => value.isEmpty
                                  ? "Enter ? if unknows eps"
                                  : null,
                              decoration: _decoration().copyWith(
                                hintText: "Total Episodes",
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  this.season = val;
                                });
                              },
                              validator: (value) =>
                                  value.isEmpty ? "Enter a valid season" : null,
                              decoration: _decoration().copyWith(
                                hintText: "Season",
                              ),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            err == null ? "" : err,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 40,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: ButtonTheme(
                                    minWidth: 120,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Colors.black,
                                      child: Text(
                                        "Add",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState.validate() &&
                                            _imageDisplay != null) {
                                          Map body = {
                                            "name": seriesName,
                                            "cover": _image64,
                                            "total": totalEps,
                                            "season": season,
                                          };
                                          var response =
                                              await _auth.addGlobalSeries(body);
                                          if (response.statusCode == 200) {
                                            Fluttertoast.showToast(
                                              msg: "Success",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor:
                                                  Color.fromRGBO(32, 26, 48, 1),
                                              textColor: Color.fromRGBO(
                                                  13, 245, 227, 1),
                                              fontSize: 16.0,
                                            );
                                            Navigator.popAndPushNamed(
                                                context, '/home');
                                          } else {
                                            setState(() {
                                              this.err =
                                                  response.body.toString();
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: 40,
                                    left: 20,
                                    right: 20,
                                  ),
                                  child: ButtonTheme(
                                    minWidth: 130,
                                    height: 50,
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10,
                                        ),
                                      ),
                                      color: Colors.black,
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.popAndPushNamed(
                                            context, '/home');
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
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

InputDecoration _decoration() {
  return InputDecoration(
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.white,
    ),
    filled: true,
    fillColor: Colors.grey[700],
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
      ),
    ),
  );
}
