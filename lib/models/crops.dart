import 'package:cloud_firestore/cloud_firestore.dart';

class Crop {
  final String id; // Add the id field
  final String cropNameEng;
  final String cropNameUrdu;
  final String typeEng;
  final String typeUrdu;
  final String discriptionEng;
  final String discriptionUrdu;
  final String imagePath;

  Crop({
    required this.id, 
    required this.cropNameEng,
    required this.cropNameUrdu,
    required this.typeEng,
    required this.typeUrdu,
    required this.discriptionEng,
    required this.discriptionUrdu,
    required this.imagePath,
  });

  factory Crop.fromJson(Map<String, dynamic> json, String id) {
    return Crop(
      id: id, // Assign the id field
      cropNameEng: json['cropNameEng'] ?? '',
      cropNameUrdu: json['cropNameUrdu'] ?? '',
      typeEng: json['typeEng'] ?? '',
      typeUrdu: json['typeUrdu'] ?? '',
      discriptionEng: json['discriptionEng'] ?? '',
      discriptionUrdu: json['discriptionUrdu'] ?? '',
      imagePath: json['imagePath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cropNameEng': cropNameEng,
      'cropNameUrdu': cropNameUrdu,
      'typeEng': typeEng,
      'typeUrdu': typeUrdu,
      'discriptionEng': discriptionEng,
      'discriptionUrdu': discriptionUrdu,
      'imagePath': imagePath,
    };
  }
  factory Crop.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Crop(
      id: doc.id,
      cropNameEng: data['cropNameEng'] ?? '',
      cropNameUrdu: data['cropNameUrdu'] ?? '',
      typeEng: data['typeEng'] ?? '',
      typeUrdu: data['typeUrdu'] ?? '',
      discriptionEng: data['discriptionEng'] ?? '',
      discriptionUrdu: data['discriptionUrdu'] ?? '',
      imagePath: data['imagePath'] ?? '',
    );
  }
}
