class SupportTopic {
  final String topicEng;
  final String topicUrdu;
  final String descriptionEng;
  final String descriptionUrdu;

  SupportTopic({
    required this.topicEng,
    required this.topicUrdu,
    required this.descriptionEng,
    required this.descriptionUrdu,
  });

  factory SupportTopic.fromJson(Map<String, dynamic> json) {
    return SupportTopic(
      topicEng: json['topicEng'] ?? '',
      topicUrdu: json['topicUrdu'] ?? '',
      descriptionEng: json['descriptionEng'] ?? '',
      descriptionUrdu: json['descriptionUrdu'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topicEng': topicEng,
      'topicUrdu': topicUrdu,
      'descriptionEng': descriptionEng,
      'descriptionUrdu': descriptionUrdu,
    };
  }
}
