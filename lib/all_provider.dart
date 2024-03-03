import 'package:cardgame/rank_class.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AllProvider extends ChangeNotifier {
  double count = 0;
  List<String> list = [
    'Frame1',
    'Frame2',
    'Frame3',
    'Frame4',
    'Frame5',
    'Frame6',
    'Frame7',
    'Frame8'
  ];
  List<String> shufflecard = [];
  List<int> correctCard = [];
  int? selectCard1;
  int? selectCard2;
  bool isLoading = false;
  List<RankCehck> rankList = [];
  String music = 'music1';
  final player = AudioPlayer();
  bool musicOn = true;
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

  selectCard(int order) async {
    if (selectCard2 == null) {
      if (selectCard1 == null) {
        selectCard1 = order;
        await load(500);
      } else if (selectCard1 != order) {
        selectCard2 = order;
        await load(500);
        Future.delayed(const Duration(milliseconds: 1), () async {
          if (shufflecard[selectCard2!] != shufflecard[selectCard1!]) {
            await load(500);
            selectCard1 = null;
            selectCard2 = null;
          } else {
            correctCard.add(selectCard2!);
            correctCard.add(selectCard1!);
            selectCard1 = null;
            selectCard2 = null;
          }
        });
      }
    }
    notifyListeners();
  }

  Future load(int time) async {
    isLoading = true;
    notifyListeners();

    await Future.delayed(Duration(milliseconds: time), () {
      isLoading = false;
    });
    notifyListeners();
  }

  addRank(RankCehck data) {
    rankList.add(data);
    notifyListeners();
  }

  initRank() {
    rankList.clear();
    notifyListeners();
  }

  chageRanks(List<RankCehck> datas) {
    rankList = datas;
    notifyListeners();
  }

  musicPlay() async {
    await player.setAsset("assets/$music.mp3");
    await player.play();
    notifyListeners();
  }

  musicPause() async {
    await player.stop();
    notifyListeners();
  }

  musicChange() async {
    if ((music == 'music1') && musicOn) {
      musicOn = true;
      music = 'music2';
      notifyListeners();
      await player.setAsset("assets/$music.mp3");
      await player.play();
    } else if ((music == 'music2') && musicOn) {
      musicOn = false;
      notifyListeners();
      await player.stop();
    } else if (!musicOn) {
      musicOn = true;
      music = 'music1';
      notifyListeners();
      await player.setAsset("assets/$music.mp3");
      await player.play();
    }
  }

  musicOff() async {
    if (musicOn) {
      musicOn = false;
      await player.stop();
    } else {
      musicOn = true;
      await player.setAsset("assets/$music.mp3");
      await player.play();
    }
    notifyListeners();
  }
}
