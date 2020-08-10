import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugars_calculation/src/blocs/show_only_carbohydrates_sugar_bloc.dart';
import 'package:sugars_calculation/src/widgets/components/calculate_second_pattern_page.dart';

/// 炭水化物と食物繊維の記載がないパターンのスクリーン
class CalculateSecondPatternScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<ShowOnlyCarbohydratesSugarBloc>(
      create: (_) => ShowOnlyCarbohydratesSugarBloc(),
      child: CalculateSecondPatternPage(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
