/// 糖質計算結果のViewHelper
class CalculationResultViewHelper {
  getSugarDegreeText(double sugarValue) {
    if (sugarValue <= 6.5) {
      return '低い◎';
    } else if (sugarValue >= 6.6 || sugarValue <= 8.6) {
      return '普通△';
    } else {
      /// 糖質8.7g以上
      return '高い×';
    }
  }
}
