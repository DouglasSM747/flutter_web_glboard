import 'package:flutter/material.dart';
import 'package:glboard_web/src/features/auth/auth_controller.dart';
import 'package:glboard_web/src/features/general_analysis/general_analysis_controller.dart';
import 'package:glboard_web/src/features/general_analysis/general_analysis_page.dart';
import 'package:glboard_web/src/features/list_games/list_games_dev_controller.dart';
import 'package:glboard_web/src/features/list_games/list_games_dev_page.dart';
import 'package:glboard_web/src/features/list_players/list_players.dart';
import 'package:glboard_web/src/features/list_players/list_players_controller.dart';
import 'package:glboard_web/src/features/register_user/register_controller.dart';
import 'package:glboard_web/src/features/register_user/register_page.dart';
import 'package:glboard_web/src/shared/service_http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'features/auth/auth_page.dart';
import 'features/list_games/create_game_dialog/create_game_controller.dart';
import 'features/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ClientHttp()),
        ChangeNotifierProvider(
          create: (context) => RegisterController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => ListGamesDevController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateGameDevController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => GeneralAnalysisController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => ListPlayersController(context.read()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GLBoard - WEB',
        theme: ThemeData(
          textTheme: GoogleFonts.robotoSlabTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashPage(),
          '/auth': (_) => const AuthPage(),
          '/register': (_) => const RegisterPage(),
          '/listgamesdev': (_) => const ListGamesDev(),
          '/general_analysis': (_) => const GeneralAnalysis(""),
          '/list_players': (_) => const ListPlayers(""),
        },
      ),
    );
  }
}
