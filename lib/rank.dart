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
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 20, top: 20),
            height: 70,
            alignment: Alignment.centerRight,
            width: double.infinity,
            color: Colors.pink[50],
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.cancel),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.pink[50],
            height: MediaQuery.sizeOf(context).height - 70,
            child: ListView.builder(
              itemCount: context.read<AllProvider>().rankList.length,
              // itemCount: 3,
              itemBuilder: (context, index) {
                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  margin: EdgeInsets.only(bottom: 30),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: Row(
                    children: [
                      Text('$index'),
                      SizedBox(width: 30),
                      Text('name'),
                      Spacer(),
                      Text('time')
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
