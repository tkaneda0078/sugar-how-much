import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugars_check/src/blocs/sugars_bloc.dart';
import 'package:sugars_check/src/widgets/components/calculate_second_pattern_page.dart';

/// 炭水化物と食物繊維の記載がないパターンのスクリーン
class CalculateSecondPatternScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SugarsBloc>(
      create: (_) => SugarsBloc(),
      child: CalculateSecondPatternPage(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
