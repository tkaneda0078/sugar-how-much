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

  final _resultController = StreamController<int>();

  Stream<int> get sugars => _resultController.stream;

  SugarsBloc() {
    _calculateFirstPatternController.stream
        .listen((CalculateFirstPatternEvent event) {
      _resultController.sink
          .add(event.carbohydrateQuantity - event.dietaryFiber);
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
