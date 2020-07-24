import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';

import '../models/SearchProvider.dart';

class ResultsScreen extends StatefulWidget {
  ResultsScreen({Key key, @required this.searchString}) : super(key: key);

  final String searchString;

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  TextEditingController searchBoxController = TextEditingController();

  Future resultsScreenFuture;

  Future<dynamic> callSearchAll() async {
    SearchProvider searchProvider =
        Provider.of<SearchProvider>(context, listen: false);
    print(searchProvider.search);
    final HttpsCallable functionCallable =
        CloudFunctions.instance.getHttpsCallable(
      functionName: 'searchAll',
    );

    HttpsCallableResult response;

    print("Sending request");
    response = await functionCallable.call(
      <String, dynamic>{
        "search": searchProvider.search,
      },
    );
    print("Request done");

    print(response.data);
    print(response.data.runtimeType);
    print(response.data[0]["title"]);
    print("Data should have printed?");

    print("Putting returned list into DataRows...");

    // Makes an empty list to hold the DataRows
    List<DataRow> processedData = [];

    for (var i in response.data) {
      processedData.add(DataRow(cells: [
        DataCell(Text(i["title"])),
        DataCell(Text(i["size"])),
        DataCell(Text(i["seeds"].toString())),
        DataCell(Text(i["peers"].toString())),
        DataCell(Text(i["time"]))
      ]));
    }

    return processedData;
  }

  @override
  void initState() {
    super.initState();
    resultsScreenFuture = callSearchAll();
  }

  @override
  Widget build(BuildContext context) {
    searchBoxController.text = widget.searchString;

    return Scaffold(
      appBar: AppBar(title: Text('Results for "${widget.searchString}"')),
      body: Center(
        child: FutureBuilder(
          future: resultsScreenFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                child: DataTable(columns: [
                  DataColumn(label: Text("Title")),
                  DataColumn(label: Text("Size")),
                  DataColumn(label: Text("Seeders")),
                  DataColumn(label: Text("Peers")),
                  DataColumn(label: Text("Date Created"))
                ], rows: snapshot.data),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
