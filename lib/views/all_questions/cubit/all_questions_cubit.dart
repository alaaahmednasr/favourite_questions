import 'package:favourite_questions/data/repository/local_db_repo.dart';
import 'package:favourite_questions/services/helper_functions/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/questions_model.dart';
import '../../../services/local/cache_service.dart';
import '../../../utils/constants/questions_list.dart';
import 'all_questions_states.dart';

class AllQuestionsCubit extends Cubit<AllQuestionsStates> {
  AllQuestionsCubit() : super(AllQuestionsInitial());

  static AllQuestionsCubit getCubit(context) => BlocProvider.of(context);

  final LocalDbRepo _localDbRepo = LocalDbRepo();

  List<QuestionsModel> questionsList = [];

  void loadQuestionsFromDb() async {
    emit(AllQuestionsLoading());
    try {
      await _localDbRepo.loadQuestionsFromDatabase().then((value) {
        if (value.isEmpty) {
          _localDbRepo.saveQuestionsToDatabase(
            questionsList: ConstantsQuestionsList.questions,
          );
          questionsList = ConstantsQuestionsList.questions;
        } else {
          questionsList = value;
        }
      });
      emit(AllQuestionsSuccess());
    } catch (e) {
      emit(AllQuestionsError());
    }
  }

  void addQuestionToFavourites({
    required String questionId,
    required BuildContext context,
  }) {
    for (var question in questionsList) {
      if (question.id == questionId) {
        HelperFunctions.showSnackBar(
          context,
          question.isFavourite
              ? 'Question removed from favorites'
              : 'Question added to favorites',
        );
        question.isFavourite = !question.isFavourite;
        _localDbRepo.updateQuestionFavouriteStatus(question);
        SharedPreferencesService().saveBoolValue(
          key: question.id,
          value: question.isFavourite,
        );
        break;
      }
    }
    emit(AddQuestionToFavourite());
  }

  bool isFavourite({
    required String questionId,
  }) {
    return SharedPreferencesService().getBoolValue(
      key: questionId,
    );
  }
}
