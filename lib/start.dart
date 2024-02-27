import 'package:cardgame/game.dart';
import 'package:cardgame/all_provider.dart';
import 'package:cardgame/rank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Made\nby\nINCOM',
                    style: TextStyle(color: Colors.pink[100], fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                      onPressed: () {
                        context.read<AllProvider>().setStart();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamePage(),
                            ));
                      },
                      child: Text(
                        'Game Start',
                        style: TextStyle(color: Colors.pink.withOpacity(0.5)),
                      ))
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Rank()));
                      },
                      icon: const Icon(Icons.grade)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
