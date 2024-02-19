import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/application/downloads/downloads_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/domain/core/di/injectable.dart';
import 'package:netflix/presentation/main_page/screen_main_page.dart';

import 'application/fast_laugh/fast_laugh_bloc.dart';
import 'application/home/home_bloc.dart';
import 'application/hot_and_new/hot_and_new_bloc.dart';
import 'application/search/search_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   configureInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx) => getIt<DownloadsBloc>()),
        BlocProvider(create: (ctx) => getIt<SearchBloc>()),
        BlocProvider(create: (ctx) => getIt<FastLaughBloc>()),
        BlocProvider(create: (ctx) => getIt<HotAndNewBloc>()),
        BlocProvider(create: (ctx) => getIt<HomeBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
              color: Colors.white,
            ),
            bodyMedium: TextStyle(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: Colors.black),
        ),
        home: const ScreenMainPage(),
      ),
    );
  }
}
