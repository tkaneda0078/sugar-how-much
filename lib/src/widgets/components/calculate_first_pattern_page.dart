import 'package:flutter/material.dart';
import 'package:sugar_how_much/src/blocs/sugars_bloc.dart';
import 'package:sugar_how_much/src/resources/helpers/validation_helper.dart';

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
                      child: Image.asset('assets/images/sugars.png',
                          width: 50, height: 50)),
                  this.carbohydrateQuantityFormField(context),
                  this.dietaryFiberFormField(context),
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
                                fontWeight: FontWeight.bold,
                                fontFamily: 'KosugiMaru',
                            )
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
                              fontWeight: FontWeight.bold,
                              fontFamily: 'KosugiMaru',
                            )
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
                                this.carbohydrate, this.dietaryFiber));
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
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  /// 炭水化物用FormField
  TextFormField carbohydrateQuantityFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: '炭水化物',
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
        this.carbohydrate = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return '炭水化物を入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
    );
  }

  /// 食物繊維用FormField
  TextFormField dietaryFiberFormField(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      maxLength: 10,
      decoration: InputDecoration(
        labelText: '食物繊維',
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
        this.dietaryFiber = double.parse(value);
      },
      validator: (value) {
        if (value.isEmpty) {
          return '食物繊維を入力してください。';
        }

        if (!Validator.isNumeric(value)) {
          return '数字を入力してください。';
        }

        return null;
      },
    );
  }
}
