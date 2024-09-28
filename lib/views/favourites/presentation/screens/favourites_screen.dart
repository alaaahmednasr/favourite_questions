import 'package:favourite_questions/utils/widgets/back_arrow.dart';
import 'package:favourite_questions/views/favourites/presentation/widgets/favourites_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/favourites_cubit.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => FavouritesCubit()..loadFavouriteQuestionsFromDb(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _appBar(context: context),
                const FavouritesWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar({
    required BuildContext context,
  }) {
    return Row(
      children: [
        const BackArrow(),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10.0),
          child: Text(
            'All Favourites Questions',
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
