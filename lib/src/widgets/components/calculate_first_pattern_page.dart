import 'package:flutter/material.dart';
import 'package:sugars_calculation/src/blocs/sugars_bloc.dart';
import 'package:sugars_calculation/src/resources/helpers/validation_helper.dart';

/// 炭水化物と食物繊維の記載があるパターンの計算画面
class CalculateFirstPatternPage extends StatelessWidget {
  /// 炭水化物
  /// double
  double carbohydrate;

  /// 食物繊維
  /// double
  double dietaryFiber;

  final formKey = GlobalKey<FormState>();
  final SugarsBloc sugarsBloc = SugarsBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('糖質計算'),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              this.carbohydrateQuantityFormField(context),
              this.dietaryFiberFormField(context),
              StreamBuilder(
                  stream: sugarsBloc.sugars,
                  builder: (context, snapshot) {
                    if (snapshot.data == null || snapshot.data == 0) {
                      return Text('');
                    }

                    return RichText(
                      text: TextSpan(
                        text: snapshot.data['sugar'].toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 50),
                        children: <TextSpan>[
                          TextSpan(
                              text: snapshot.data['sugarDegreeText']
                                  .toString() // TODO: レイアウト調整
                              )
                        ],
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: RaisedButton(
                  child: Text('計算する'),
                  color: Colors.yellow, // TODO: カラー変更
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  /// 送信ボタンクリック時の処理
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      formKey.currentState.save();
                      sugarsBloc.calculate.add(
                          CalculateEvent(this.carbohydrate, this.dietaryFiber));
                    }
                  },
                ),
              ),
              RaisedButton(
                child: Text('リセット'),
                color: Colors.yellow, // TODO: カラー変更
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  formKey.currentState.reset();
                  sugarsBloc.resetCalculationResult();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 炭水化物用FormField
  TextFormField carbohydrateQuantityFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      maxLength: 10,
      validator: (value) {
        if (value.isEmpty) {
          return '入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: '炭水化物を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.carbohydrate = double.parse(value);
      },
    );
  }

  /// 食物繊維用FormField
  TextFormField dietaryFiberFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      maxLength: 10,
      validator: (value) {
        if (value.isEmpty) {
          return '入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: '食物繊維を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.dietaryFiber = double.parse(value);
      },
    );
  }
}
