import 'dart:math';

import 'package:cardgame/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCard extends StatefulWidget {
  final int order;
  const CustomCard({super.key, required this.order});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  double _angle = 0;
  @override
  Widget build(BuildContext context) {
    late int order = widget.order;
    return GestureDetector(
      onTap: () async {
        if ((context.read<AllProvider>().selectCard1 != order) &&
            (context.read<AllProvider>().selectCard2 == null) &&
            (!context.read<AllProvider>().correctCard.contains(order))) {
          _angle = (_angle + pi) % (2 * pi);
          setState(() {});
          await Future.delayed(const Duration(milliseconds: 250), () {
            context.read<AllProvider>().selectCard(order);
            _angle = (_angle + pi) % (2 * pi);
            setState(() {});
          });
        }
      },
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0, end: _angle),
        builder: (BuildContext context, double value, _) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0001)
              ..rotateY(value),
            child: Container(
              alignment: Alignment.center,
              width: 96,
              height: 120,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: Colors.grey),
                  image: (((context.watch<AllProvider>().selectCard1 ==
                                  order) ||
                              (context.watch<AllProvider>().selectCard2 ==
                                  order) ||
                              (context
                                  .watch<AllProvider>()
                                  .correctCard
                                  .contains(order))) ||
                          false)
                      ? DecorationImage(
                          image: AssetImage(
                              'assets/${context.read<AllProvider>().shufflecard[order]}.png'))
                      : const DecorationImage(
                          image: AssetImage('assets/INCOM.png'), scale: 8.5),
                  borderRadius: BorderRadius.circular(15),
                  color: ((context.watch<AllProvider>().selectCard1 == order) ||
                          (context.watch<AllProvider>().selectCard2 == order) ||
                          (context
                              .watch<AllProvider>()
                              .correctCard
                              .contains(order)))
                      ? Colors.white
                      : const Color(0xFFFFC3C3)),
            ),
          );
        },
      ),
    );
  }
}
