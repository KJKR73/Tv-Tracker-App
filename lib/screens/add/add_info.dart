import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddInfo extends StatelessWidget {
  Map data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(24, 24, 24, 1),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      data['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontFamily: "GM",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Image.memory(
                    data['image64'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Season",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "GM",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['season'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "GM",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Episodes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "GM",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              data['total'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "GM",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Synopsis",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: "GM",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "This feature will be available later",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: "GM",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
