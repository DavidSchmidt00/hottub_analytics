import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'input_views/heating_input.dart';
import 'input_views/temperature_input.dart';

class InputView extends StatefulWidget {
  @override
  _InputViewState createState() => _InputViewState();
  
}

class _InputViewState extends State<InputView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TemperaturInput(),
          const Divider(
            height: 0,
          ),
          HeizInput(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
