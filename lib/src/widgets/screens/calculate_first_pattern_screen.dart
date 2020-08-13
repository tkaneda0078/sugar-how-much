import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_how_much/src/widgets/components/calculate_first_pattern_page.dart';
import 'package:sugar_how_much/src/blocs/sugars_bloc.dart';

/// 炭水化物と食物繊維の記載があるパターンのスクリーン
class CalculateFirstPatternScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SugarsBloc>(
      create: (_) => SugarsBloc(),
      child: CalculateFirstPatternPage(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
