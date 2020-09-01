import 'package:flutter/material.dart';
import 'package:tv_tracker_flutter/customWidgets/add_widget.dart';

class AddPage extends StatefulWidget {
  dynamic data;
  dynamic height;
  dynamic width;
  AddPage({this.height, this.width, this.data});
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: widget.height,
        width: widget.width,
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
                        setState(() {});
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
                  child: ListView.separated(
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
                      );
                    },
                  )),
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
                          onPressed: () {
                            Navigator.popAndPushNamed(context, '/addnew');
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
