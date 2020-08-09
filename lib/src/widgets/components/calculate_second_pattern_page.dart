import 'package:flutter/material.dart';
import 'package:sugars_check/src/blocs/sugars_bloc.dart';

/// 炭水化物のみの記載パターンの計算画面
class CalculateSecondPatternPage extends StatelessWidget {

  /// 総カロリー
  /// double
  double totalCalories;

  /// 脂質
  /// double
  double lipid;

  /// タンパク質
  /// double
  double protein;

  final formKey = GlobalKey<FormState>();
  final SugarsBloc sugarsBloc = SugarsBloc();

  void calculate(double carbohydrateQuantity, double dietaryFiber) {
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
              this.totalCaloriesFormField(context),
              this.lipidFormField(context),
              this.proteinFormField(context),
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
//                      this.calculate(
//                          this.carbohydrateQuantity, this.dietaryFiber);
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

  /// 総カロリー用FormField
  TextFormField totalCaloriesFormField(BuildContext context) {
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
          labelText: '総カロリーを入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.totalCalories = double.parse(value);
      },
    );
  }

  /// 脂質用FormField
  TextFormField lipidFormField(BuildContext context) {
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
          labelText: '脂質を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.lipid = double.parse(value);
      },
    );
  }

  /// タンパク質用FormField
  TextFormField proteinFormField(BuildContext context) {
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
          labelText: 'タンパク質を入力してください。',
          hintText: '123',
          icon: Icon(Icons.device_unknown)),
      onSaved: (value) {
        this.protein = double.parse(value);
      },
    );
  }
}
