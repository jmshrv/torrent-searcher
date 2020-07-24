import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;

import 'screens/MainScreen.dart';
import 'screens/ResultsScreen.dart';
import 'models/SearchProvider.dart';

void main() {
  // timeDilation = 5;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
        )
      ],
      child: TorrentSearcher(),
    ),
  );
}

class TorrentSearcher extends StatelessWidget {
  const TorrentSearcher({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
    );
  }
}
