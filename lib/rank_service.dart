import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum QuizType { Quiz1, Quiz2, Quiz3, Quiz4 }

class RankService extends ChangeNotifier {
  final quizType1 = FirebaseFirestore.instance.collection('QuizType1');
  final quizType2 = FirebaseFirestore.instance.collection('QuizType2');
  final quizType3 = FirebaseFirestore.instance.collection('QuizType3');
  final quizType4 = FirebaseFirestore.instance.collection('QuizType4');

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await quizType1.get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    return quizType1.where('uid', isEqualTo: uid).get();
  }

  void create(QuizType type, String nickName, int score, String uid) async {
    switch (type) {
      case QuizType.Quiz1:
        await quizType1.doc(nickName).set({
          'uid': uid,
          'score': score,
        });
        break;
      case QuizType.Quiz2:
        await quizType2.doc(nickName).set({
          'uid': uid,
          'score': score,
        });
        break;
      case QuizType.Quiz3:
        await quizType3.doc(nickName).set({
          'uid': uid,
          'score': score,
        });
        break;
      case QuizType.Quiz4:
        await quizType4.doc(nickName).set({
          'uid': uid,
          'score': score,
        });
        break;
    }
    notifyListeners();
  }

  void update(QuizType type, String nickName, int score, String uid) async {
    switch (type) {
      case QuizType.Quiz1:
        await quizType1.doc(nickName).update({
          'score': score,
        });
        break;
      case QuizType.Quiz2:
        await quizType2.doc(nickName).update({
          'score': score,
        });
        break;
      case QuizType.Quiz3:
        await quizType3.doc(nickName).update({
          'score': score,
        });
        break;
      case QuizType.Quiz4:
        await quizType4.doc(nickName).update({
          'score': score,
        });
        break;
    }
    notifyListeners();
  }

  void delete(String docId) async {
    // bucket 삭제
    await quizType1.doc(docId).delete();
    notifyListeners();
  }
}
