import 'package:finance_app/models/data/commissions-data.dart';
import 'package:finance_app/models/data/shares-data.dart';

class TransactionSumData {
  final SharesData _sharesData;
  final CommissionsData _commissionsData;

  TransactionSumData(this._sharesData, this._commissionsData);

  CommissionsData get commissionsData => _commissionsData;

  SharesData get sharesData => _sharesData;

  double get totalFees =>
      commissionsData.buyCommission.calculate(
          data: sharesData.purchasePrice * sharesData.sharesQuantity) +
      commissionsData.sellCommission.calculate(
          data: sharesData.sellingPrice * sharesData.sharesQuantity) +
      spreadFee;

  double get spreadFee {
    if (sharesData.sellingPrice <= sharesData.purchasePrice) return 0;
    return commissionsData.spreadFee *
        ((sharesData.sellingPrice * sharesData.sharesQuantity) -
            (sharesData.purchasePrice * sharesData.sharesQuantity));
  }

  double get profit {
    return (sharesData.sellingPrice * sharesData.sharesQuantity) -
        (sharesData.purchasePrice * sharesData.sharesQuantity) -
        (sharesData.sellingPrice > sharesData.purchasePrice
            ? totalFees
            : commissionsData.buyCommission.calculate(data: sharesData.sharesQuantity * sharesData.purchasePrice) +
            commissionsData.sellCommission.calculate(data: sharesData.sharesQuantity * sharesData.sellingPrice));
  }

  double get roi {
    double totalCommissions =
        commissionsData.buyCommission.calculate(data: sharesData.sharesQuantity * sharesData.purchasePrice) +
            commissionsData.sellCommission.calculate(data: sharesData.sharesQuantity * sharesData.sellingPrice);
    return (profit /
        (sharesData.purchasePrice * sharesData.sharesQuantity + totalCommissions)) *
        100;
  }
}
