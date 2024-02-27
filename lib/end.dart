

import 'package:cardgame/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EndPage extends StatefulWidget {
  const EndPage({super.key});

  @override
  State<EndPage> createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                    '${(context.read<AllProvider>().count).toStringAsFixed(1)} 초',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 50,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 3
                        ..color = Colors.pink.withOpacity(0.6),
                    )),
              ],
            ),
            const SizedBox(height: 30),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: Color(0xFFF5F7FF),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 1, color: Colors.pink.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('게임 종료!',
                      style: TextStyle(fontSize: 25, color: Colors.pink[200])),
                )),
          ],
        ),
      ),
    );
  }
}
