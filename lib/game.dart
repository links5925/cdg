import 'dart:async';

import 'package:cardgame/card.dart';
import 'package:cardgame/end.dart';
import 'package:cardgame/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final player = AudioPlayer();
  late Timer timer;
  @override
  void initState() {
    super.initState();
    setdefault();
    bool isMusic = context.read<AllProvider>().musicOn;
    if (isMusic) {
      context.read<AllProvider>().musicPlay();
    }
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
              context.read<AllProvider>().musicPause();
            },
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      context.read<AllProvider>().musicOff();
                    },
                    icon: context.watch<AllProvider>().musicOn
                        ? const Icon(
                            Icons.music_note,
                            color: Color(0xffF97A7A),
                          )
                        : const Icon(Icons.music_off)),
                automaticallyImplyLeading: false,
                title: Text(
                  '${(context.watch<AllProvider>().count).toStringAsFixed(1)}초',
                  style: TextStyle(color: Colors.pink[100]),
                ),
                centerTitle: true,
              ),
              body: ListView.builder(
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
