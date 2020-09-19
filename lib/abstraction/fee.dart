abstract class IFee {
  double get value;

  bool usePercentage;
  double calculate({double data});
}