import 'dart:ui';

import 'time.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

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
    initialRoute: "/login",
  ));
}

class city extends StatefulWidget {
  city({Key? key}) : super(key: key);

  @override
  _cityState createState() => _cityState();
}

class _cityState extends State<city> {
  List<dynamic> data = [
    "Africa/Cairo",
    "America/Chicago",
    "Europe/Paris",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "cities",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 8, 66, 89),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: data
              .map((currentcity) => InkWell(
                    onTap: () {
                      setState(() {
                        Navigator.pushNamed(context, "/time", arguments: {
                          "selectedCity": currentcity,
                        });
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.all(50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color.fromARGB(255, 3, 113, 132),
                            child: (currentcity == 'Africa/Cairo')
                                ? Image.asset('assets/egypt.jpg')
                                : (currentcity == "America/Chicago")
                                    ? Image.asset('assets/amercia.jpg')
                                    : Image.asset('assets/france.jpg'),
                          ),
                          Text(
                            currentcity,
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
                  ))
              .toList(),
        ),
      ),
    );
  }
}
