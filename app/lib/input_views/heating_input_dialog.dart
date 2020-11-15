import 'package:flutter/material.dart';

class HeizInputDialog extends StatefulWidget {
  final TextEditingController tc;
  final Function onSumbit;

  HeizInputDialog({this.tc, this.onSumbit});

  @override
  _HeizInputDialogState createState() => _HeizInputDialogState();
}

class _HeizInputDialogState extends State<HeizInputDialog> {

  TextEditingController tc;
  bool initalHeat =false;

  @override
  Widget build(BuildContext context) {
    var tc = widget.tc;

    return SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      title: Text("Heizvorgang erfassen"),
      children: [
        TextField(
          controller: tc,
          decoration: InputDecoration(hintText: "Holzscheite"),
          autofocus: true,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
        ),
        Center(
          child: Row(
            children: [
              Text("Feuer neu angemacht?"),
              Checkbox(
                value: initalHeat,
                onChanged: (value) {
                  setState(() {
                    initalHeat = value;
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              widget.onSumbit(tc.text, initalHeat);
              tc.text = "";
            },
            child: Text("Ok"),
          ),
        )
      ],
    );
  }
}
