import 'package:flutter/material.dart';
import 'package:sugar_how_much/src/blocs/show_only_carbohydrates_sugar_bloc.dart';
import 'package:sugar_how_much/src/resources/helpers/validation_helper.dart';

/// 炭水化物のみの記載パターンの計算画面
class CalculateSecondPatternPage extends StatelessWidget {
  /// 総カロリー
  /// double
  double calorie;

  /// 脂質
  /// double
  double lipid;

  /// タンパク質
  /// double
  double protein;

  final formKey = GlobalKey<FormState>();
  final ShowOnlyCarbohydratesSugarBloc sugarsBloc =
      ShowOnlyCarbohydratesSugarBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/images/sample.jpg',
                          width: 50, height: 50)),
                  this.totalCaloriesFormField(context),
                  this.lipidFormField(context),
                  this.proteinFormField(context),
                  StreamBuilder(
                      stream: sugarsBloc.sugars,
                      builder: (context, snapshot) {
                        if (snapshot.data == null || snapshot.data == 0) {
                          return Text('');
                        }

                        return Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                      text: '糖質：' +
                                          snapshot.data['sugar'].toString() +
                                          'g',
                                      style: TextStyle(
                                          color: Color(0xFF272343),
                                          fontSize: 30,
                                          fontFamily: 'KosugiMaru')
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: '\n' +
                                          snapshot.data['sugarDegreeText']
                                              .toString(),
                                      style: TextStyle(
                                          color: Color(0xFF272343),
                                          fontSize: 30,
                                          fontFamily: 'KosugiMaru')
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        child: Text('リセット',
                            style: TextStyle(
                                color: Color(0xFF272343),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KosugiMaru')
                        ),
                        color: Color(0xFFbae8e8),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          formKey.currentState.reset();
                          sugarsBloc.resetCalculationResult();
                        },
                      ),
                      RaisedButton(
                        child: Text('計算する',
                            style: TextStyle(
                                color: Color(0xFF272343),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KosugiMaru')
                        ),
                        color: Color(0xFFbae8e8),
                        shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        /// 送信ボタンクリック時の処理
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            formKey.currentState.save();
                            sugarsBloc.calculate.add(CalculateEvent(
                                this.calorie, this.lipid, this.protein));
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF272343),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  /// 総カロリー用FormField
  TextFormField totalCaloriesFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'カロリー',
        labelStyle: TextStyle(
            color: Color(0xFF272343).withOpacity(0.8),
            fontSize: 16.0,
            fontFamily: 'KosugiMaru',
            fontWeight: FontWeight.bold
        ),
        hintText: '10.0',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF272343), width: 2.0),
        ),
      ),
      onSaved: (value) {
        this.calorie = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'カロリーを入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
    );
  }

  /// 脂質用FormField
  TextFormField lipidFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: '脂質',
        labelStyle: TextStyle(
            color: Color(0xFF272343).withOpacity(0.8),
            fontSize: 16.0,
            fontFamily: 'KosugiMaru',
            fontWeight: FontWeight.bold
        ),
        hintText: '1',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF272343), width: 2.0),
        ),
      ),
      onSaved: (value) {
        this.lipid = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return '脂質を入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
    );
  }

  /// タンパク質用FormField
  TextFormField proteinFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: 'タンパク質',
        labelStyle: TextStyle(
            color: Color(0xFF272343).withOpacity(0.8),
            fontSize: 16.0,
            fontFamily: 'KosugiMaru',
            fontWeight: FontWeight.bold
        ),
        hintText: '1',
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF272343), width: 2.0),
        ),
      ),
      onSaved: (value) {
        this.protein = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'タンパク質を入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
    );
  }
}
