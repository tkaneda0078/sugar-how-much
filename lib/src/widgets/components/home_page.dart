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
                text: 'ようこそ',
                style: TextStyle(
                    color: Color(0xFF272343),
                    fontSize: 18,
                    fontFamily: 'KosugiMaru',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0, bottom: 50.0),
              child: Center(
                child: Image.asset('assets/images/sugar.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: RichText(
                text: TextSpan(
                  text: '炭水化物と植物繊維が両方記載されている',
                  style: TextStyle(
                      color: Color(0xFF272343),
                      fontSize: 18,
                      fontFamily: 'KosugiMaru',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Row(
              /// 各ボタン間のスペースを均等
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text('はい',
                      style: TextStyle(
                          color: Color(0xFF272343),
                          fontWeight: FontWeight.bold)),
                  color: Color(0xFFbae8e8),
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
                  child: Text('いいえ',
                      style: TextStyle(
                          color: Color(0xFF272343),
                          fontWeight: FontWeight.bold)),
                  color: Color(0xFFbae8e8),
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
