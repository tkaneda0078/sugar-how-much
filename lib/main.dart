import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/widgets/components/home_page.dart';
import 'src/widgets/screens/calculate_first_pattern_screen.dart';
import 'src/widgets/screens/calculate_second_pattern_screen.dart';

Future main() async {
  await DotEnv().load('.env');
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'KosugiMaru'),
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('ja', ''),
    ],
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/calculate_first_pattern': (context) => CalculateFirstPatternScreen(),
      '/calculate_second_pattern': (context) => CalculateSecondPatternScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomePage());
  }
}
