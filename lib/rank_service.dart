import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum QuizType { Quiz1, Quiz2, Quiz3, Quiz4 }

class RankService extends ChangeNotifier {
  final bucketCollection = FirebaseFirestore.instance.collection('bucket');

  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    return bucketCollection.where('uid', isEqualTo: uid).get();
  }

  void create(QuizType type, int score, String uid) async {
    await bucketCollection.add({
      'uid': uid,
      'quiztype': type.toString(),
      'score': score,
    });
    notifyListeners();
  }

  void update(String docId, bool isDone) async {
    // bucket isDone 업데이트
    await bucketCollection.doc(docId).update({"isDone": isDone});
    notifyListeners();
  }

  void delete(String docId) async {
    // bucket 삭제
    await bucketCollection.doc(docId).delete();
    notifyListeners();
  }
}
