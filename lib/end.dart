import 'package:cardgame/all_provider.dart';
import 'package:cardgame/rank_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EndPage extends StatefulWidget {
  const EndPage({super.key});

  @override
  State<EndPage> createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  double timer = 0;
  bool newRank = false;
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  @override
  void initState() {
    super.initState();
    timer = context.read<AllProvider>().count;
    newRank = check();
    setState(() {});
    context.read<AllProvider>().musicPause();
  }

  bool check() {
    final List<RankCehck> datas = context.read<AllProvider>().rankList;
    if (double.parse(datas[4].time) > timer) {
      return true;
    }
    return false;
  }

  Future uploadNewRank() async {
    RankCehck now =
        RankCehck(name: name.text, number: number.text, time: timer.toString());
    List<RankCehck> datas = context.read<AllProvider>().rankList;
    List<RankCehck> lists = [];
    bool isBeing = false;
    for (RankCehck a in datas) {
      if (a.number == now.number) {
        bool better = false;
        isBeing = true;
        if (double.parse(a.time) > double.parse(now.time)) {
          better = true;
        }
        if (!better) return;
        break;
      }
    }

    for (int i = 0; i < 7; i++) {
      if (double.parse(datas[i].time) > double.parse(now.time)) {
        lists.add(now);
        for (int j = i; j < (isBeing ? 7 : 6); j++) {
          if (now.number != datas[j].number) {
            lists.add(datas[j]);
          }
        }
        break;
      } else {
        lists.add(datas[i]);
      }
    }
    context.read<AllProvider>().initRank();
    context.read<AllProvider>().chageRanks(lists);
    datas = context.read<AllProvider>().rankList;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 7; i++) {
      await prefs.setStringList('${i + 1}',
          <String>[(datas[i].name), (datas[i].number), datas[i].time]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffeded),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${(timer).toStringAsFixed(1)}초',
                  style: const TextStyle(
                      fontFamily: 'Cormorant_Upright',
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF97A7A)),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
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
                                image: AssetImage('assets/END.png'), scale: 3)),
                      ),
                    )),
              ],
            ),
          ),
          newRank
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xffffeded),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        const Text(
                          '신기록!',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF97A7A)),
                        ),
                        const SizedBox(height: 60),
                        Container(
                          width: 300,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('이름'),
                              TextField(
                                controller: name,
                              ),
                              const SizedBox(height: 30),
                              const Text('전화번호'),
                              TextField(
                                controller: number,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 120),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  newRank = false;
                                  setState(() {});
                                },
                                child: const Text(
                                  'SKIP',
                                  style: TextStyle(
                                      color: Color(0xffF97A7A), fontSize: 18),
                                )),
                            const SizedBox(width: 100),
                            GestureDetector(
                                onTap: () {
                                  if ((name.text != '') && number.text != '') {
                                    uploadNewRank();
                                    newRank = false;
                                    setState(() {});
                                  }
                                },
                                child: const Text(
                                  '확인',
                                  style: TextStyle(
                                      color: Color(0xffF97A7A), fontSize: 20),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
