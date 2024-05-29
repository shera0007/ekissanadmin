import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekissanadmin/models/form.dart';

class FormService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FormModel>> getForms() async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('schemesforms')
          .where('status', isEqualTo: 0)
          .get();
      return querySnapshot.docs.map((doc) => FormModel.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching forms: $e');
      return [];
    }
  }

  Future<void> updateFormStatus(FormModel form, int status, String description) async {
    try {
      // Log the userEmail to ensure it's being passed correctly
      print('Updating form status for userEmail: ${form.userEmail}');

      // Update form status
      await _firestore.collection('schemesforms').doc(form.id).update({'status': status});

      // Add notification
      await _firestore.collection('notifications').add({
        'type': 'forms',
        'description': description,
        'timestamp': FieldValue.serverTimestamp(),
        'userEmail': form.userEmail,  // Use the userEmail from the form
      });
    } catch (e) {
      print('Error updating form status: $e');
    }
  }
}
