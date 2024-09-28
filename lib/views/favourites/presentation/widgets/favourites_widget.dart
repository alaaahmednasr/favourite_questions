import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

import '../../../../resources/colors/colors.dart';
import '../../../../resources/icons/icons.dart';
import '../../../../utils/widgets/loading_animation.dart';
import '../../cubit/favourites_cubit.dart';
import '../../cubit/favourites_states.dart';

class FavouritesWidget extends StatelessWidget {
  const FavouritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritesCubit, FavouritesStates>(
      builder: (context, state) {
        var allQuestionsCubit = FavouritesCubit.getCubit(context);
        return Expanded(
          child: (state is FavouritesLoading)
              ? const Center(
                  child: LoadingAnimation(),
                )
              : (allQuestionsCubit.favouritesQuestionsList.isEmpty)
                  ? _emptyFavouriteList(context: context)
                  : _favouritesList(allQuestionsCubit: allQuestionsCubit),
        );
      },
    );
  }

  Widget _emptyFavouriteList({
    required BuildContext context,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          emptyFavouritesList,
          width: 300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Text(
            'No Favourite Questions Yet'.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 30,
                  color: ColorPalette.secondaryBlack,
                ),
          ),
        ),
      ],
    );
  }

  Widget _favouritesList({
    required FavouritesCubit allQuestionsCubit,
  }) {
    return ListView.builder(
      padding: const EdgeInsetsDirectional.only(
        bottom: 20,
        top: 10,
        start: 5,
        end: 5,
      ),
      physics: const BouncingScrollPhysics(),
      itemCount: allQuestionsCubit.favouritesQuestionsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 20.0,
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
                        allQuestionsCubit
                            .favouritesQuestionsList[index].question,
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
                      allQuestionsCubit.removeQuestionFromFavourites(
                        questionId:
                            allQuestionsCubit.favouritesQuestionsList[index].id,
                        context: context,
                      );
                    },
                    child: SvgPicture.asset(
                      starFilled,
                    ),
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
