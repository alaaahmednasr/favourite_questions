import 'package:favourite_questions/resources/colors/colors.dart';
import 'package:favourite_questions/services/routes/route_service.dart';
import 'package:favourite_questions/utils/enums/route_enum.dart';
import 'package:favourite_questions/views/all_questions/presentation/widgets/questions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../resources/icons/icons.dart';
import '../../cubit/all_questions_cubit.dart';

class AllQuestionsScreen extends StatefulWidget{
  const AllQuestionsScreen({super.key});

  @override
  State<AllQuestionsScreen> createState() => _AllQuestionsScreenState();
}

class _AllQuestionsScreenState extends State<AllQuestionsScreen> with RouteAware {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AppRouter.routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    AppRouter.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    context.read<AllQuestionsCubit>().loadQuestionsFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AppRouter.router.pushNamed(AppRoute.favourites.name),
        child: SvgPicture.asset(
          favouritesList,
          width: 30,
        ),
      ),
      body: Column(
        children: [
          _appBar(context: context),
          const QuestionsWidget(),
        ],
      ),
    );
  }

  Widget _appBar({
    required BuildContext context,
  }) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: const BoxDecoration(
        color: ColorPalette.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      child: Text(
        'All Interview Questions',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: ColorPalette.secondaryWhite,
            ),
      ),
    );
  }
}
