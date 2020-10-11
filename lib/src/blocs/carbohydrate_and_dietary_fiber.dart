import 'dart:async';
import 'package:sugar_how_much/src/resources/helpers/calculation_result_view_helper.dart';

class CalculateEvent {
  final double carbohydrate;
  final double dietaryFiber;

  CalculateEvent(this.carbohydrate, this.dietaryFiber);
}

class CarbohydrateAndDietaryFiberBloc {
  final _calculateController = StreamController<CalculateEvent>();

  Sink<CalculateEvent> get calculate => _calculateController.sink;

  final _resultController = StreamController<Map>();

  Stream<Map> get sugars => _resultController.stream;

  CarbohydrateAndDietaryFiberBloc() {
    _calculateController.stream.listen((CalculateEvent event) {
      var sugar = event.carbohydrate - event.dietaryFiber;
      _resultController.sink.add({
        'sugar': sugar,
        'sugarDegreeText':
            CalculationResultViewHelper().getSugarDegreeText(sugar)
      });
    });
  }

  void resetCalculationResult() {
    _resultController.sink.add(null);
  }

  void dispose() {
    _calculateController.close();
    _resultController.close();
  }
}
