import 'package:flutter/material.dart';
import 'package:sugars_check/src/blocs/sugars_bloc.dart';

/// 炭水化物と食物繊維の記載があるパターンの計算画面
class CalculateFirstPatternPage extends StatelessWidget {

  /// 炭水化物
  /// int
  int carbohydrateQuantity;

  /// 食物繊維
  /// int
  int dietaryFiber;

  final formKey = GlobalKey<FormState>();
  final SugarsBloc sugarsBloc = SugarsBloc();

  void calculate(int carbohydrateQuantity, int dietaryFiber) {
    sugarsBloc.calculate
        .add(CalculateFirstPatternEvent(carbohydrateQuantity, dietaryFiber));
  }

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
                    return RichText(
                      text: TextSpan(
                        text: snapshot.data != null
                            ? snapshot.data.toString()
                            : '',
                        style: TextStyle(color: Colors.blue, fontSize: 50),
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
                      this.calculate(
                          this.carbohydrateQuantity, this.dietaryFiber);
                    }
                  },
                ),
              ),
              RaisedButton(
                child: Text('戻る'),
                color: Colors.yellow, // TODO: カラー変更
                shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  Navigator.pop(context);
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
      validator: (value) {
        if (value.isEmpty) {
          return '入力してください。';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: '炭水化物を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.carbohydrateQuantity = int.parse(value);
      },
    );
  }

  /// 食物繊維用FormField
  TextFormField dietaryFiberFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value.isEmpty) {
          return '入力してください。';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: '食物繊維を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.dietaryFiber = int.parse(value);
      },
    );
  }
}
