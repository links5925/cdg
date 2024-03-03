import 'package:cardgame/all_provider.dart';
import 'package:cardgame/rank_class.dart';
import 'package:cardgame/start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AllProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i < 8; i++) {
      final List<String> items = prefs.getStringList('$i')!;
      RankCehck data =
          RankCehck(name: items[0], number: items[1], time: items[2]);
      context.read<AllProvider>().addRank(data);
    }
  }

  // setData() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setStringList('1', <String>['name1', 'nuber1', '10001']);
  //   await prefs.setStringList('2', <String>['name2', 'nuber2', '10002']);
  //   await prefs.setStringList('3', <String>['name3', 'nuber3', '10003']);
  //   await prefs.setStringList('4', <String>['name4', 'nuber4', '10004']);
  //   await prefs.setStringList('5', <String>['name5', 'nuber5', '10005']);
  //   await prefs.setStringList('6', <String>['name6', 'nuber6', '10006']);
  //   await prefs.setStringList('7', <String>['name7', 'nuber7', '10007']);
  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: StartPage(),
      ),
    );
  }
}
