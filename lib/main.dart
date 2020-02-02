import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final appTitle = '糖質計算';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: this.appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text(this.appTitle),
          ),
          body: Container(
            margin: EdgeInsets.only(
                left: 20.0, top: 30.0, right: 20.0, bottom: 30.0
            ),
            child: MyHomePage(),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();

  /// 糖質
  /// int
  int sugars;

  /// 炭水化物
  /// int
  int carbohydrateQuantity;

  /// 食物繊維
  /// int
  int dietaryFiber;

  void updateCarbohydrateQuantity(int carbohydrateQuantity) {
    setState(() {
      this.carbohydrateQuantity = carbohydrateQuantity;
    });
  }

  void updateDietaryFiber(int dietaryFiber) {
    setState(() {
      this.dietaryFiber = dietaryFiber;
    });
  }

  void updateSugars(int carbohydrateQuantity, int dietaryFiber) {
    setState(() {
      this.sugars = carbohydrateQuantity - dietaryFiber;
    });
  }

  /// 糖質値を出力する
  /// return int
  int outputSugars() => this.carbohydrateQuantity - this.dietaryFiber;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          this.carbohydrateQuantityFormField(context),
          this.dietaryFiberFormField(context),
          RichText(
            text: TextSpan(
              text: this.sugars != null ? this.sugars.toString() : '',
              style: TextStyle(color: Colors.blue, fontSize: 50),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              // 送信ボタンクリック時の処理
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  this.updateSugars(
                      this.carbohydrateQuantity, this.dietaryFiber
                  );
                }
              },
              child: Text('submit'),
            ),
          ),
        ],
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
        updateCarbohydrateQuantity(int.parse(value));
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
        updateDietaryFiber(int.parse(value));
      },
    );
  }
}
