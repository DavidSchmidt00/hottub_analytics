import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../settings/settings.dart' as settings;


class TemperaturInput extends StatefulWidget {
  @override
  _TemperaturInputState createState() => _TemperaturInputState();
}

class _TemperaturInputState extends State<TemperaturInput> {
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
              Icons.waves,
              size: 100,
              color: Colors.blueAccent,
            ),
            Text("Temperatur erfassen")
          ],
        ),
      ),
      onTap: () async => await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(20),
            title: Text("Temperatur erfassen"),
            children: [
              TextField(
                controller: textController,
                decoration: InputDecoration(hintText: "Temperatur"),
                autofocus: true,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () => onSubmit(),
                  child: Text("Ok"),
                ),
              )
            ],
          );
        },
      ).then((value) => textController.text = ""),
    ));
  }

  Future<http.Response> postTemp(double temp) {
    print("Post temperature " + temp.toString());
    return http.post(
      settings.BACKEND_URL+'/temperatur',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, double>{
        'temperature': temp,
      }),
    );
  }

  void onSubmit() {
    var temp;
    temp = null;
    try {
      temp =
          double.parse(textController.text.replaceAll(new RegExp(r","), "."));
    } catch (e) {
      print("Input is not a double");
      Scaffold.of(context).showSnackBar(snackBar("Bitte gib nur Zahlen ein"));
    }
    if (temp != null) {
      postTemp(temp).timeout(Duration(seconds: 2)).then((value) {
        if (value.statusCode != 200) {
          print("Error on post temp");
          Scaffold.of(context).showSnackBar(snackBar("Keine Verbindung"));
        }
      }).catchError((e) {
        print("Error on post temp");
        Scaffold.of(context).showSnackBar(snackBar("Keine Verbindung"));
      });
    }
    Navigator.of(context).pop();
    textController.text = "";
  }

  SnackBar snackBar(String text) {
    return SnackBar(
          content: Text(
            "Fehler: "+text,
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red,
        );
  }
}
