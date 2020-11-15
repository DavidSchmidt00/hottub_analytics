import 'package:badefass_analyse/input_view.dart';
import 'package:badefass_analyse/settings/settings_view.dart';
import 'package:flutter/material.dart';

import 'analyse_view.dart';

void main() {
  runApp(BadefassAnalyse());
}

class BadefassAnalyse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Badefass Analyse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: TabController(),
    );
  }
}

class TabController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Badefass Analyse"),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsView()),
                  );
                },
              )
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.post_add_rounded)),
                Tab(
                  icon: Icon(Icons.analytics),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [InputView(), AnalyseView()],
          ),
        ));
  }
}
