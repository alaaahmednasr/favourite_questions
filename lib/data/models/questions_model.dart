class QuestionsModel {
  late String id;
  late String question;
  late bool isFavourite;

  QuestionsModel({
    required this.id,
    required this.question,
    required this.isFavourite,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) {
    return QuestionsModel(
      id: json['id'].toString(),
      question: json['question'].toString(),
      isFavourite: json['isFavourite'] == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'isFavourite': isFavourite.toString(),
    };
  }
}
