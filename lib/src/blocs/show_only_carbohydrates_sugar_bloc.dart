import 'dart:async';
import 'package:sugars_calculation/src/resources/helpers/calculation_result_view_helper.dart';

/// 炭水化物のみ記載があるパターン
/// TODO: ファイル分けする
class CalculateEvent {
  final double calorie;
  final double lipid;
  final double protein;

  CalculateEvent(this.calorie, this.lipid, this.protein);
}

class ShowOnlyCarbohydratesSugarBloc {
  final _calculateController = StreamController<CalculateEvent>();

  Sink<CalculateEvent> get calculate => _calculateController.sink;

  final _resultController = StreamController<Map>();

  Stream<Map> get sugars => _resultController.stream;

  ShowOnlyCarbohydratesSugarBloc() {
    _calculateController.stream.listen((CalculateEvent event) {
      var sugar = _calculateSugar(event.calorie, event.lipid, event.protein);
      _resultController.sink.add({
        'sugar': sugar,
        'sugarDegreeText':
            CalculationResultViewHelper().getSugarDegreeText(sugar)
      });
    });
  }

  /// 炭水化物のみ表示時の計算式
  /// 糖質(g) = ((カロリー) – (脂質g × 9) - (タンパク質 g× 4)) ÷ 4
  double _calculateSugar(double totalCalories, double lipid, double protein) {
    var sugar = (totalCalories - (lipid * 9) - (protein * 4)) / 4;

    return sugar;
  }

  void resetCalculationResult() {
    _resultController.sink.add(null);
  }

  void dispose() {
    _calculateController.close();
    _resultController.close();
  }
}
