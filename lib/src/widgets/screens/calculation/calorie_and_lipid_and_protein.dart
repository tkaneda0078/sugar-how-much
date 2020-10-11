import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_how_much/src/blocs/calorie_and_lipid_and_protein.dart';
import 'package:sugar_how_much/src/widgets/calculation/calorie_and_lipid_and_protein.dart';

/// 総カロリーとタンパク質と脂質の計算スクリーン
class CalorieAndLipidAndProteinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<CalorieAndLipidAndProteinBloc>(
      create: (_) => CalorieAndLipidAndProteinBloc(),
      child: CalorieAndLipidAndProtein(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
