import 'package:finance_app/models/commission_fee.dart';

class CommissionsData {
  final CommissionFee _buyCommission;
  final CommissionFee _sellCommission;
  final double _spreadFee;

  CommissionsData(this._buyCommission, this._sellCommission, this._spreadFee);

  CommissionFee get buyCommission => _buyCommission;
  CommissionFee get sellCommission => _sellCommission;
  double get spreadFee => _spreadFee;
}