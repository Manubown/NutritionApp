import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const titletext = "Nutrition App";

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

int kcal = 1800;
int verbraucht = 0;
int gegessen = 0;
int verbrennt = 0;
List<Table> items = new List<Table>();

int _selectedIndex = 0;

Color mainColor = Colors.blue;

var date = "23:40";

class _HomeState extends State<Home> {
  bool onMeals = false;
  ColorSwatch _tempMainColor;
  String titletext = "Home,Nutrition Plan,Calendar,Profile";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 100,
            title: Text(
              titletext.split(',')[_selectedIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: mainColor,
              ),
            ),
            bottom: TabBar(
              indicatorColor: mainColor,
              tabs: [
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    child: new Tab(
                      icon: Icon(
                        Icons.home,
                        color: mainColor,
                      ),
                    )), //Home
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    child: new Tab(
                      icon: Icon(
                        Icons.assignment,
                        color: mainColor,
                      ),
                    )), //Nutrition Plan
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    child: new Tab(
                      icon: Icon(
                        Icons.calendar_today,
                        color: mainColor,
                      ),
                    )), //Calendar
                Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    child: new Tab(
                      icon: Icon(
                        Icons.person_rounded,
                        color: mainColor,
                      ),
                    )), //Profile
              ],
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          body: TabBarView(children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Table(
                    children: [
                      TableRow(children: [
                        Container(),
                        Text(""),
                        Container(),
                      ]),
                      TableRow(children: [
                        Container(),
                        Text(
                          '$kcal',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(),
                      ]),
                      TableRow(children: [
                        Text(
                          '$gegessen',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'übrig',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$verbrennt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          'gegessen',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Container(),
                        Text(
                          'verbrannt',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                      TableRow(children: [
                        Container(),
                        Text(""),
                        Container(),
                      ]),
                      // Text zu Werte
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                ), //Topbar
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          Text(
                            "Timeline",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Switch(
                              activeColor: mainColor,
                              value: onMeals,
                              onChanged: (value) {
                                setState(() {
                                  onMeals = value;
                                });
                              }),
                          Text(
                            "Daily meals",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ), //Switch
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext ctxt, int Index) {
                        return InkWell(
                          onTap: () => {
                            /*
                            setState(() {
                              kcal -= 100;
                            })
                             */
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context, Index),
                            )
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            height: 80,
                            child: items[Index],
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                              /*
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  )
                                ]*/
                            ),
                          ),
                        );
                      }),
                ), //Content
              ],
            ), //Home
            Column(
              children: [Text("Place holder for Nutrition Plan")],
            ), //Nutrition Plan
            Column(
              children: [
                Container(
                  child: Text("Placeholder for Calendar"),
                ),
              ],
            ), //Calendar
            Column(
              children: [
                InkWell(
                  onTap: () {
                    /*
                    _openDialog(
                      "Select a Color",
                      MaterialColorPicker(
                        selectedColor: mainColor,
                        allowShades: false,
                        onMainColorChange: (color) => setState(() => _tempMainColor = color),
                      ),
                    );
                    */
                    _openDialog(
                      "Color picker",
                      MaterialColorPicker(
                        selectedColor: mainColor,
                        onColorChange: (color) =>
                            setState(() => mainColor = color),
                        onMainColorChange: (color) =>
                            setState(() => _tempMainColor = color),
                        onBack: () => print("Back button pressed"),
                      ),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        children: [
                          Text(
                            "Color: ",
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            Icons.widgets_sharp,
                            color: mainColor,
                            size: 30,
                          )
                        ],
                      )),
                )
              ],
            ), //Profile
          ]),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              height: 50.0,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            onPressed: () => setState(() {
              //Todo: Add meal
              //kcal -= 100;
              items.add(
                new Table(
                    children: [
                      TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Text(GetDateTime(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          Container(),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Text(
                              "Calories: $cal",
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
              ); //Create time sheet
            }),
            tooltip: 'Increment Counter',
            child: Icon(
              Icons.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  } //MainApp

  String GetDateTime() {
    return DateTime.now().hour.toString().padLeft(2, '0') +
        ":" +
        DateTime.now().minute.toString().padLeft(2, '0');
  } //GetDateForTimeLine

  void editBlock(int index){
    setState((){


    });
  }

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10.0),
          title: Text(title),
          content: content,
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() => mainColor = _tempMainColor);
              },
            ),
          ],
        );
      },
    );
  } //WindowOpeningDialog
}

Widget _buildPopupDialog(BuildContext context, int index) {
  return new AlertDialog(
    title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello "+index.toString()),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}



int cal = 0;
