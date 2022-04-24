import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'main.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'login.dart';
import 'signup.dart';
import 'package:intl/intl.dart';

main() {
  runApp(MaterialApp(
    title: "Date&Time",
    debugShowCheckedModeBanner: false,
    routes: {
      "/city": (context) => city(),
      "/time": (context) => time(),
      "/login": (context) => login(),
      "/signup": (context) => signup(),
    },
    initialRoute: "/city",
  ));
}

class time extends StatefulWidget {
  time({Key? key}) : super(key: key);

  @override
  _timeState createState() => _timeState();
}

class _timeState extends State<time> {
  String URL = 'http://worldtimeapi.org/api/timezone/';
  Map API_data = {};
  bool flag = true;
  String cityURL = '';
  String offsetTime = "+02:00";
  DateTime now = DateTime.now();
  int timeZone = 0;
  String Time = "";
  String Month = "";
  String op = '+';
  getData() async {
    try {
      Response res = await get(Uri.parse(URL));
      now = DateTime.parse(
          API_data['datetime'] ?? "2021-10-17T12:13:40.760447+02:00");
      timeZone = int.parse(offsetTime.substring(1, 3));
      op = offsetTime[0];
      print("catch");
      setState(() {
        API_data = jsonDecode(res.body);
        offsetTime = API_data["utc_offset"];
        now = DateTime.parse(API_data['datetime']);
        if (op == '+')
          now = now.add(Duration(hours: timeZone));
        else if (op == '-') now = now.subtract(Duration(hours: timeZone));
        Time = DateFormat.jms().format(now);
        Month = DateFormat.yMd().format(now);
        print("inn");
      });
    } catch (e) {
      print("object");
      setState(() {
        Time = "Error";
        Month = "Check your connection";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> mycities =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    cityURL = mycities['selectedCity'] ?? 'Africa/Cairo';
    if (flag) {
      URL += cityURL;
      flag = false;
    }
    getData();

    print(API_data['datetime']);
    if (API_data['datetime'] == null && Time == '') {
      return Scaffold(
          backgroundColor: Color.fromARGB(255, 8, 66, 89),
          body: Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 8, 66, 89),
            title: Text("Time and date"),
          ),
          body: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Time,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        Text(
                          Month,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 3, 113, 132),
                      border: Border.all(color: Colors.deepOrange.shade50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            ),
          ));
    }
  }
}
