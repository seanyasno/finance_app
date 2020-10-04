class SharesData {
  final double _purchasePrice;
  final double _sellingPrice;
  final int _sharesQuantity;

  SharesData(this._purchasePrice, this._sellingPrice, this._sharesQuantity);

  int get sharesQuantity => _sharesQuantity;
  double get sellingPrice => _sellingPrice;
  double get purchasePrice => _purchasePrice;

  double get spread => (sellingPrice * sharesQuantity) - (purchasePrice * sharesQuantity);
}