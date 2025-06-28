


import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/FeedBack/feedback_data.dart';
class FeedBackRepository{
  FeedBackRepository();



  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createFeedBackToFirebase({required FeedBackData feedbackData}) {
    return _db.collection("FeedBack").doc().set(feedbackData.toJsonCreateFeedBack());
  }

}