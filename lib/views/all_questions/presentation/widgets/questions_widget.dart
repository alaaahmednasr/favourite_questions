import 'package:favourite_questions/views/all_questions/cubit/all_questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/icons/icons.dart';
import '../../../../utils/widgets/loading_animation.dart';
import '../../cubit/all_questions_states.dart';

class QuestionsWidget extends StatelessWidget {
  const QuestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllQuestionsCubit, AllQuestionsStates>(
      builder: (context, state) {
        var allQuestionsCubit = AllQuestionsCubit.getCubit(context);
        return Expanded(
          child: (state is AllQuestionsLoading)
              ? const Center(
                  child: LoadingAnimation(),
                )
              : _questionsList(allQuestionsCubit: allQuestionsCubit),
        );
      },
    );
  }

  Widget _questionsList({required AllQuestionsCubit allQuestionsCubit}) {
    return ListView.builder(
      padding: const EdgeInsetsDirectional.only(bottom: 80),
      physics: const BouncingScrollPhysics(),
      itemCount: allQuestionsCubit.questionsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 20.0,
            start: 20,
            end: 20,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.primaryBlack.withOpacity(0.3),
                  blurRadius: 3,
                  blurStyle: BlurStyle.outer,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(question),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        allQuestionsCubit.questionsList[index].question,
                        maxLines: 4,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: ColorPalette.secondaryBlack,
                            ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: InkWell(
                    onTap: () {
                      allQuestionsCubit.addQuestionToFavourites(
                        questionId: allQuestionsCubit.questionsList[index].id,
                        context: context,
                      );
                    },
                    child: allQuestionsCubit.isFavourite(
                            questionId:
                                allQuestionsCubit.questionsList[index].id)
                        ? SvgPicture.asset(starFilled)
                        : SvgPicture.asset(star),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
