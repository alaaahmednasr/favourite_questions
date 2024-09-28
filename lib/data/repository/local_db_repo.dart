import '../../services/local/local_database.dart';
import '../models/questions_model.dart';

class LocalDbRepo {
  void saveQuestionsToDatabase({
    required List<QuestionsModel> questionsList,
  }) async {
    try {
      await QuestionsDatabase().insertRows(questionsList);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuestionsModel>> loadQuestionsFromDatabase() async {
    try {
      return await QuestionsDatabase().readAllRows();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<QuestionsModel>> loadFavouriteQuestionsFromDatabase() async {
    try {
      return await QuestionsDatabase().readAllFavouriteQuestions();
    } catch (e) {
      rethrow;
    }
  }

  void updateQuestionFavouriteStatus(QuestionsModel question) async {
    try {
      await QuestionsDatabase().updateRow(question);
    } catch (e) {
      rethrow;
    }
  }
}
