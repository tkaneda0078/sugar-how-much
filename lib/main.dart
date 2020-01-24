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
          body: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  /// 炭水化物
  /// int
  int carbohydrateQuantity = 0;

  void _updateCarbohydrateQuantity(int carbohydrateQuantity) {
    setState(() {
      this.carbohydrateQuantity = carbohydrateQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          this.carbohydrateQuantityFormField(context),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('成功')));
                }
              },
              child: Text('submit'),
            ),
          )
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
        _updateCarbohydrateQuantity(int.parse(value));
      },
    );
  }
}
