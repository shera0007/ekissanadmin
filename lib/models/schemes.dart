// scheme_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Scheme {
  final String id;
  final String schemeNameEng;
  final String schemeNameUrdu;
  final String detailsEng;
  final String detailsUrdu;
  final String imagePath;

  Scheme({
    required this.id,
    required this.schemeNameEng,
    required this.schemeNameUrdu,
    required this.detailsEng,
    required this.detailsUrdu,
    required this.imagePath,
  });

  factory Scheme.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Scheme(
      id: doc.id,
      schemeNameEng: data['schemeNameEng'] ?? '',
      schemeNameUrdu: data['schemeNameUrdu'] ?? '',
      detailsEng: data['detailsEng'] ?? '',
      detailsUrdu: data['detailsUrdu'] ?? '',
      imagePath: data['imagePath'] ?? '',
    );
  }
}
