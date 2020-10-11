import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sugar_how_much/src/widgets/components/calculation/carbohydrate_and_dietary_fiber.dart';
import 'package:sugar_how_much/src/blocs/sugars_bloc.dart';

/// 炭水化物と食物繊維の計算スクリーン
class CarbohydrateAndDietaryFiberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<SugarsBloc>(
      create: (_) => SugarsBloc(),
      child: CarbohydrateAndDietaryFiber(),
      dispose: (context, value) => value.dispose(),
    );
  }
}
