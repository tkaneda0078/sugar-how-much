import 'package:flutter/material.dart';
import 'package:sugars_calculation/src/widgets/screens/calculate_first_pattern_screen.dart';
import 'package:sugars_calculation/src/widgets/screens/calculate_second_pattern_screen.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              /// 各ボタン間のスペースを均等
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('ある'),
                  color: Colors.yellow, // TODO: カラー変更
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculateFirstPatternScreen()),
                    );
                  },
                ),
                RaisedButton(
                  child: Text('ない'),
                  color: Colors.yellow, // TODO: カラー変更
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculateSecondPatternScreen()),
                    );
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
