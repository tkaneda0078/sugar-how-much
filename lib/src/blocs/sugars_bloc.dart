import 'dart:async';
import 'package:sugars_check/src/resources/helpers/calculation_result_view_helper.dart';

/// 炭水化物と食物繊維の記載があるパターン
class CalculateFirstPatternEvent {
  final double carbohydrateQuantity;
  final double dietaryFiber;

  CalculateFirstPatternEvent(this.carbohydrateQuantity, this.dietaryFiber);
}

class SugarsBloc {
  final _calculateFirstPatternController =
      StreamController<CalculateFirstPatternEvent>();

  Sink<CalculateFirstPatternEvent> get calculate =>
      _calculateFirstPatternController.sink;

  final _resultController = StreamController<Map>();

  Stream<Map> get sugars => _resultController.stream;

  SugarsBloc() {
    _calculateFirstPatternController.stream
        .listen((CalculateFirstPatternEvent event) {
      var calculationResult = event.carbohydrateQuantity - event.dietaryFiber; // TODO: 小数点計算できていない
      _resultController.sink.add({
        'calculationResult': calculationResult,
        'sugarDegreeText': CalculationResultViewHelper()
            .getSugarDegreeText(calculationResult)
      });
    });
  }

  void calculateSugar(double carbohydrateQuantity, double dietaryFiber) {
    calculate
        .add(CalculateFirstPatternEvent(carbohydrateQuantity, dietaryFiber));
  }

  void resetCalculationResult() {
    _resultController.sink.add(null);
  }

  void dispose() {
    _calculateFirstPatternController.close();
    _resultController.close();
  }
}
