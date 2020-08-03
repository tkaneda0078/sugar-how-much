import 'dart:async';

/// 炭水化物と食物繊維の記載があるパターン
class CalculateFirstPatternEvent {
  final int carbohydrateQuantity;
  final int dietaryFiber;

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
      _resultController.sink.add({
        'calculationResult': event.carbohydrateQuantity - event.dietaryFiber,
        'sugarDegreeText': 'test' // TODO: メソッドから糖質度合のテキストを取得
      });
    });
  }

  void calculateSugar(int carbohydrateQuantity, int dietaryFiber) {
    calculate
        .add(CalculateFirstPatternEvent(carbohydrateQuantity, dietaryFiber));
  }

  void resetCalculationResult() {
    calculate.add(CalculateFirstPatternEvent(0, 0));
  }

  void dispose() {
    _calculateFirstPatternController.close();
    _resultController.close();
  }
}
