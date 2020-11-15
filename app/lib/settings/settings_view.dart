import 'package:flutter/material.dart';

import '../settings/settings.dart' as settings;

class SettingsView extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Einstellungen"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              title: Text(settings.BACKEND_URL),
              trailing: IconButton(icon: Icon(Icons.edit), onPressed: () {},),
            ),

          ),
        ],
      ),
    );
  }
}
