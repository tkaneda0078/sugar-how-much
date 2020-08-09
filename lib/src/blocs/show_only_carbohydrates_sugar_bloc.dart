import 'dart:async';
import 'package:sugars_check/src/resources/helpers/calculation_result_view_helper.dart';

/// 炭水化物のみ記載があるパターン
/// TODO: ファイル分けする
class CalculateEvent {
  final double totalCalories;
  final double lipid;
  final double protein;

  CalculateEvent(this.totalCalories, this.lipid, this.protein);
}

class ShowOnlyCarbohydratesSugarBloc {
  final _calculateController = StreamController<CalculateEvent>();

  Sink<CalculateEvent> get calculate => _calculateController.sink;

  final _resultController = StreamController<Map>();

  Stream<Map> get sugars => _resultController.stream;

  ShowOnlyCarbohydratesSugarBloc() {
    _calculateController.stream.listen((CalculateEvent event) {
      // TODO : 計算用の関数作成
      var calculationResult = event.totalCalories - event.lipid - event.protein;
      _resultController.sink.add({
        'calculationResult': calculationResult,
        'sugarDegreeText': CalculationResultViewHelper()
            .getSugarDegreeText(calculationResult)
      });
    });
  }

  void calculateSugar(double totalCalories, double lipid, double protein) {
    calculate.add(CalculateEvent(totalCalories, lipid, protein));
  }

  void resetCalculationResult() {
    _resultController.sink.add(null);
  }

  void dispose() {
    _calculateController.close();
    _resultController.close();
  }
}
