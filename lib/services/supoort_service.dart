import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekissanadmin/models/support.dart';


class SupportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSupportTopic(SupportTopic topic) async {
    try {
      await _firestore.collection('support_topics').add(topic.toJson());
    } catch (e) {
      print('Error adding support topic: $e');
      throw e;
    }
  }

  Future<void> updateSupportTopic(String id, SupportTopic topic) async {
    try {
      await _firestore.collection('support_topics').doc(id).update(topic.toJson());
    } catch (e) {
      print('Error updating support topic: $e');
      throw e;
    }
  }
}
