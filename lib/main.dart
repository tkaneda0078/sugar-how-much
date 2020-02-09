import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: '糖質計算',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('糖質計算'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: '炭水化物と植物繊維の表示はある？',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              // 各ボタン間のスペースを均等
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('ある'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('ない'),
                  onPressed: () {
                    // TODO: 別画面
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => ),
//                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
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

  void _updateCarbohydrateQuantity(int carbohydrateQuantity) {
    setState(() {
      this.carbohydrateQuantity = carbohydrateQuantity;
    });
  }

  void _updateDietaryFiber(int dietaryFiber) {
    setState(() {
      this.dietaryFiber = dietaryFiber;
    });
  }

  void _updateSugars(int carbohydrateQuantity, int dietaryFiber) {
    setState(() {
      this.sugars = carbohydrateQuantity - dietaryFiber;
    });
  }

  /// 糖質値を出力する
  /// return int
  int outputSugars() => this.carbohydrateQuantity - this.dietaryFiber;

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
                      this._updateSugars(
                          this.carbohydrateQuantity, this.dietaryFiber);
                    }
                  },
                  child: Text('submit'),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('戻る'),
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
        _updateCarbohydrateQuantity(int.parse(value));
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
        _updateDietaryFiber(int.parse(value));
      },
    );
  }
}
