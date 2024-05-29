import 'package:cloud_firestore/cloud_firestore.dart';

class FormModel {
  final String id;
  final String firstName;
  final String lastName;
  final String cnic;
  final String landSize;
  final String monthlyIncome;
  final String educationalQualification;
  final String scheme;
  final String? landOwnershipHistoryImageUrl;
  final String? educationalCertificateImageUrl;
  final String? landProofImageUrl;
  final int status;
  final String userEmail;

  FormModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cnic,
    required this.landSize,
    required this.monthlyIncome,
    required this.educationalQualification,
    required this.scheme,
    this.landOwnershipHistoryImageUrl,
    this.educationalCertificateImageUrl,
    this.landProofImageUrl,
    required this.status,
    required this.userEmail,
  });

  factory FormModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FormModel(
      id: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      cnic: data['cnic'] ?? '',
      landSize: data['landSize'] ?? '',
      monthlyIncome: data['monthlyIncome'] ?? '',
      educationalQualification: data['educationalQualification'] ?? '',
      scheme: data['scheme'] ?? '',
      landOwnershipHistoryImageUrl: data['landOwnershipHistoryImageUrl'],
      educationalCertificateImageUrl: data['educationalCertificateImageUrl'],
      landProofImageUrl: data['landProofImageUrl'],
      status: data['status'] ?? 0,
      userEmail: data['userEmail'] ?? '',  // Ensure userEmail is extracted correctly
    );
  }
}
