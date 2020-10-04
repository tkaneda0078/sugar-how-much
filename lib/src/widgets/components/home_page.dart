import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['diet', 'sugar off', 'weight loss'],
    contentUrl: '',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: getBannerAdUnitId(),
      size: AdSize.banner,
      targetingInfo: targetingInfo,
    );
  }

  void showBannerAd() {
    _bannerAd
      ..load()
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId: getAdAppId());
    _bannerAd = createBannerAd();
    showBannerAd();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Center(
                child: Image.asset('assets/images/sugar.png',
                    width: 150, height: 150),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: RichText(
                text: TextSpan(
                  text: '炭水化物と植物繊維\n両方記載されていますか？',
                  style: TextStyle(
                      color: Color(0xFF272343),
                      fontSize: 20,
                      fontFamily: 'KosugiMaru',
                      fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold
                      )
                  ),
                  color: Color(0xFFbae8e8),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    _bannerAd.dispose();
                    _bannerAd = null;
                    var _isReturnTransition = await Navigator.pushNamed(
                        context, '/calculate_first_pattern'
                    );

                    // 遷移先からのリターンか
                    if (_isReturnTransition) {
                      _bannerAd = createBannerAd();
                      showBannerAd();
                    }
                  },
                ),
                RaisedButton(
                  child: Text('いいえ',
                      style: TextStyle(
                          color: Color(0xFF272343),
                          fontWeight: FontWeight.bold
                      )
                  ),
                  color: Color(0xFFbae8e8),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () async {
                    _bannerAd.dispose();
                    _bannerAd = null;
                    var _isReturnTransition = await Navigator.pushNamed(
                        context, '/calculate_second_pattern'
                    );

                    print(ModalRoute.of(context).settings.name);

                    // 遷移先からのリターンか
                    if (_isReturnTransition) {
                      _bannerAd = createBannerAd();
                      showBannerAd();
                    }
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

String getAdAppId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return DotEnv().env['ADMOB_APP_ID_OF_ANDROID'];
  }

  return '';
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return '';
  } else if (Platform.isAndroid) {
    return DotEnv().env['ADMOB_UNIT_ID_OF_ANDROID'];
  }

  return '';
}
