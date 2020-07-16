import 'package:flutter/material.dart';

class ResultsScreen extends StatefulWidget {
  ResultsScreen({Key key, @required this.searchString}) : super(key: key);

  final String searchString;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  TextEditingController searchBoxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchBoxController.text = widget.searchString;

    return Scaffold(
      appBar: AppBar(title: Text('Results for "${widget.searchString}"')),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
