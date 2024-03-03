import 'package:cardgame/game.dart';
import 'package:cardgame/all_provider.dart';
import 'package:cardgame/rank.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
        backgroundColor: const Color(0xffffeded),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'CARD GAME\nWITH LOVE',
                    style: TextStyle(
                      color: Color(0xFFF87A7A),
                      fontSize: 48,
                      fontFamily: 'Cormorant Upright',
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                      onTap: () {
                        context.read<AllProvider>().setStart();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const GamePage(),
                            ));
                      },
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/Logo.png'))),
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/START.png'),
                                  scale: 3)),
                        ),
                      ))
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 20),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.read<AllProvider>().musicChange();
                          },
                          icon: context.watch<AllProvider>().musicOn
                              ? const Icon(
                                  Icons.music_note,
                                  color: Color(0xffF97A7A),
                                )
                              : const Icon(Icons.music_off)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Rank()));
                          },
                          icon: const Icon(
                            Icons.format_list_numbered,
                            color: Color(0xffF97A7A),
                            size: 30,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
