import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'src/widgets/screens/home.dart';
import 'src/widgets/screens/calculation/carbohydrate_and_dietary_fiber.dart';
import 'src/widgets/screens/calculation/calorie_and_lipid_and_protein.dart';

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
      '/': (context) => HomeScreen(),
      '/calculation/carbohydrate_and_dietary_fiber': (context) =>
          CarbohydrateAndDietaryFiberScreen(),
      '/calculation/calorie_and_lipid_and_protein': (context) =>
          CalorieAndLipidAndProteinScreen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeScreen());
  }
}
