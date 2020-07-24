import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/ResultsScreen.dart';
import '../models/SearchProvider.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Torrent Searcher"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Consumer<SearchProvider>(
                builder: (context, searchProvider, child) {
              TextEditingController searchBoxController =
                  TextEditingController();
              searchBoxController.text = searchProvider.search;
              return TextField(
                decoration: InputDecoration(labelText: "Search"),
                onSubmitted: (value) {
                  searchProvider.updateSearch(value);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ResultsScreen(
                        searchString: value,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      )),
    );
  }
}
