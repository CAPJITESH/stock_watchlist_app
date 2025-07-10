import 'package:hive/hive.dart';

part 'stock_model.g.dart';

@HiveType(typeId: 0)
class StockModel extends HiveObject {
  @HiveField(0)
  String? symbol;

  @HiveField(1)
  String? name;

  @HiveField(2)
  double? ltp;

  @HiveField(3)
  String? iconUrl;

  StockModel({this.symbol, this.name, this.ltp, this.iconUrl});

  factory StockModel.fromJson(Map<String, dynamic> json) {
    return StockModel(
      symbol: json["symbol"],
      name: json["name"],
      ltp: json["ltp"],
      iconUrl: json["icon_url"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "symbol": symbol,
      "name": name,
      "ltp": ltp,
      "icon_url": iconUrl,
    };
  }
}
