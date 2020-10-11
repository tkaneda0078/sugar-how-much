import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_how_much/src/blocs/show_only_carbohydrates_sugar_bloc.dart';
import 'package:sugar_how_much/src/widgets/components/calculation/calorie_and_lipid_and_protein.dart';

/// 総カロリーとタンパク質と脂質の計算スクリーン
class CalorieAndLipidAndProteinScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ShowOnlyCarbohydratesSugarBloc>(
      create: (_) => ShowOnlyCarbohydratesSugarBloc(),
      child: CalorieAndLipidAndProtein(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
