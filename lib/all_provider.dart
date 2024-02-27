import 'package:cardgame/rank_class.dart';
import 'package:flutter/material.dart';

class AllProvider extends ChangeNotifier {
  double count = 0;
  List<String> list = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  List<String> shufflecard = [];
  List<int> correctCard = [];
  int? selectCard1;
  int? selectCard2;
  bool isLoading = false;
  List<RankCehck> rankList = [];

  setStart() {
    count = 0;
    shufflecard = [];
    for (dynamic data in list) {
      shufflecard.add(data);
      shufflecard.add(data);
    }
    shufflecard.shuffle();
    selectCard1 = null;
    selectCard2 = null;
    correctCard = [];

    notifyListeners();
  }

  addCount() {
    count += 0.1;
    notifyListeners();
  }

  selectCard(int order) {
    if (selectCard1 == null) {
      selectCard1 = order;
      load(1);
    } else {
      selectCard2 = order;
      load(1);
      Future.delayed(const Duration(milliseconds: 500), () {
        if (shufflecard[selectCard2!] != shufflecard[selectCard1!]) {
          selectCard1 = null;
          selectCard2 = null;
          load(500);
        } else {
          correctCard.add(selectCard2!);
          correctCard.add(selectCard1!);
          selectCard1 = null;
          selectCard2 = null;
        }
      });
    }
    notifyListeners();
  }

  load(int time) {
    isLoading = true;
    notifyListeners();
    Future.delayed(Duration(milliseconds: time), () {
      isLoading = false;
    });
    notifyListeners();
  }

  initRank(RankCehck data) {
    rankList.add(data);
    notifyListeners();
  }
}
