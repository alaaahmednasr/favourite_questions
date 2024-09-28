import 'package:favourite_questions/data/repository/local_db_repo.dart';
import 'package:favourite_questions/services/helper_functions/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/questions_model.dart';
import '../../../services/local/cache_service.dart';
import 'favourites_states.dart';

class FavouritesCubit extends Cubit<FavouritesStates> {
  FavouritesCubit() : super(FavouritesInitial());

  static FavouritesCubit getCubit(context) => BlocProvider.of(context);

  final LocalDbRepo _localDbRepo = LocalDbRepo();

  List<QuestionsModel> favouritesQuestionsList = [];

  void loadFavouriteQuestionsFromDb() async {
    emit(FavouritesLoading());
    try {
      await _localDbRepo.loadFavouriteQuestionsFromDatabase().then((value) {
        favouritesQuestionsList = value;
      });
      emit(FavouritesSuccess());
    } catch (e) {
      emit(FavouritesError());
    }
  }

  void removeQuestionFromFavourites({
    required String questionId,
    required BuildContext context,
  }) {
    for (var question in favouritesQuestionsList) {
      if (question.id == questionId) {
        HelperFunctions.showSnackBar(
          context,
          'Question removed from favorites'
        );
        question.isFavourite = !question.isFavourite;
        _localDbRepo.updateQuestionFavouriteStatus(question);
        SharedPreferencesService().saveBoolValue(
          key: question.id,
          value: question.isFavourite,
        );
        favouritesQuestionsList.remove(question);
        break;
      }
    }
    emit(RemoveQuestionFromFavourite());
  }
}
