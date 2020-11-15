import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'heating_input_dialog.dart';
import '../settings/settings.dart' as settings;

class HeizInput extends StatefulWidget {
  @override
  _HeizInputState createState() => _HeizInputState();
}

class _HeizInputState extends State<HeizInput> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_fire_department,
                size: 100,
                color: Colors.deepOrange,
              ),
              Text("Heizvorgang erfassen")
            ],
          ),
        ),
        onTap: () async => await showDialog(
          context: context,
          builder: (context) {
            return HeizInputDialog(
                tc: textController,
                onSumbit: (logs, initalHeat) => onSubmit(
                      logs,
                      initalHeat,
                    ));
          },
        ).then((value) => textController.text = ""),
      ),
    );
  }

  Future<http.Response> postHeating(double logs, bool initalHeat) {
    print("Post heating " + logs.toString() + ", " + initalHeat.toString());
    return http.post(
      settings.BACKEND_URL+'/heizen',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body:
          jsonEncode(<String, Object>{'logs': logs, 'inital_heat': initalHeat}),
    );
  }

  void onSubmit(logs, initalHeat) {
    {
      try {
        logs = double.parse(logs.replaceAll(new RegExp(r","), "."));
      } catch (e) {
        print("Input is not a double");
        logs = null;
        Scaffold.of(context).showSnackBar(snackBar("Bitte gib nur Zahlen ein"));
      }
      if (logs != null) {
        postHeating(logs, initalHeat)
            .timeout(Duration(seconds: 2))
            .then((value) {
          if (value.statusCode != 200) {
            print("Error on post heating");
            Scaffold.of(context).showSnackBar(snackBar("Keine Verbindung"));
          }
        }).catchError((e) {
          print("Error on post heating");
          Scaffold.of(context).showSnackBar(snackBar("Keine Verbindung"));
        });
      }
    }
  }

  SnackBar snackBar(String text) {
    return SnackBar(
      content: Text(
        "Fehler: " + text,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
    );
  }
}
