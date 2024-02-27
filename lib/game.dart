import 'dart:async';


import 'package:cardgame/card.dart';
import 'package:cardgame/end.dart';
import 'package:cardgame/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool end = false;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    setdefault();
  }

  setdefault() {
    timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      context.read<AllProvider>().addCount();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<AllProvider>().shufflecard.length ==
            context.watch<AllProvider>().correctCard.length
        ? const EndPage()
        : PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              context.read<AllProvider>().setStart();
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  '${(context.watch<AllProvider>().count).toStringAsFixed(1)}초',
                  style: TextStyle(color: Colors.pink[100]),
                ),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        'Made by INCOM\n',
                        style: TextStyle(color: Colors.pink[100]),
                      ),
                    ),
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index1) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Spacer(),
                            customButton(index1 * 4 + 1),
                            const Spacer(),
                            customButton(index1 * 4 + 2),
                            const Spacer(),
                            customButton(index1 * 4 + 3),
                            const Spacer(),
                            customButton(index1 * 4),
                            const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ));
  }

  Widget customButton(int index) {
    return Stack(
      children: [
        CustomCard(
          order: index,
        ),
        context.watch<AllProvider>().isLoading
            ? Container(
                color: Colors.transparent,
                width: 80,
                height: 120,
              )
            : Container()
      ],
    );
  }
}
