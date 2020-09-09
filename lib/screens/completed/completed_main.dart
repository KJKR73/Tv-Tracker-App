import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tv_tracker_flutter/screens/completed/completed_widget.dart';
import 'package:tv_tracker_flutter/services/authentication/auth.dart';

class CompletedPage extends StatefulWidget {
  @override
  _CompletedPageState createState() => _CompletedPageState();
}

class _CompletedPageState extends State<CompletedPage> {
  final AuthService _auth = AuthService();
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
                  bottom: BorderSide(color: Colors.white, width: 2),
                ),
              ),
              child: Align(
                child: Text(
                  "Completed",
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
            future: _auth.getCompletedList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  flex: 9,
                  child: GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return CompletedWidget(
                        data: snapshot.data[index],
                      );
                    },
                  ),
                );
              } else {
                return Expanded(flex: 9, child: Container());
              }
            },
          )
        ],
      ),
    );
  }
}
