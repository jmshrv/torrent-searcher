import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

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
        DataCell(Text(i["time"])),
        DataCell(FlatButton(
            onPressed: () {
              // I make a variable called torrent here because I'm assuming that i will be long gone by time the user actually wants to get the magnet.
              // I haven't actually tested doing copyMagnetLink(i) but Firebase Functions doesn't work in debug mode on web so ¯\_(ツ)_/¯
              var torrent = i;
              copyMagnetLink(torrent);
            },
            child: Icon(Icons.cloud_download)))
      ]));
    }

    print("Finished putting returned list into DataRows");
    return processedData;
  }

  void copyMagnetLink(var torrent) async {
    final HttpsCallable functionCallable =
        CloudFunctions.instance.getHttpsCallable(
      functionName: 'getMagnetLink',
    );

    HttpsCallableResult response;

    print("Sending request");
    response =
        await functionCallable.call(<String, dynamic>{"torrent": torrent});
    print("Request completed");
    print(response.data);
    Clipboard.setData(ClipboardData(text: response.data));
    print("Copied to clipboard");
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
      body: SingleChildScrollView(
        child: Center(
          child: FutureBuilder(
            future: resultsScreenFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return DataTable(columns: [
                  DataColumn(label: Text("Title")),
                  DataColumn(label: Text("Size")),
                  DataColumn(label: Text("Seeders")),
                  DataColumn(label: Text("Peers")),
                  DataColumn(label: Text("Date Created")),
                  DataColumn(label: Text("Magnet"))
                ], rows: snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
