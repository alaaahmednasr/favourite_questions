import 'package:favourite_questions/resources/theme/app_theme.dart';
import 'package:favourite_questions/services/local/cache_service.dart';
import 'package:favourite_questions/services/routes/route_service.dart';
import 'package:favourite_questions/views/all_questions/cubit/all_questions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllQuestionsCubit()..loadQuestionsFromDb(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Favourite Questions',
        theme: Themes().lightTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
