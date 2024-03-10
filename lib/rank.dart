import 'package:cardgame/all_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Rank extends StatefulWidget {
  const Rank({super.key});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffeded),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20, top: 20, left: 20),
            height: 70,
            alignment: Alignment.centerRight,
            width: double.infinity,
            color: const Color(0xffffeded),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    '랭킹',
                    style: TextStyle(fontSize: 25, color: Color(0xffF97A7A)),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: const Color(0xffffeded),
            height: MediaQuery.sizeOf(context).height - 70,
            child: ListView.builder(
              itemCount: context.read<AllProvider>().rankList.length,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: const EdgeInsets.only(bottom: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}',
                        style: const TextStyle(
                            fontSize: 16, color: Color(0xffF97A7A)),
                      ),
                      const SizedBox(width: 30),
                      Text(context.read<AllProvider>().rankList[index].name,
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xffF97A7A))),
                      const Spacer(),
                      Text(
                          '${double.parse(context.read<AllProvider>().rankList[index].time).toStringAsFixed(1)}초',
                          style: const TextStyle(
                              fontSize: 16, color: Color(0xffF97A7A)))
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
