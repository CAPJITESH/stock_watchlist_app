import 'package:hive/hive.dart';
import 'package:stock_watch_list/features/stock_watch_list/models/stock_model.dart';

class WatchlistService {
  static final Box<StockModel> _box = Hive.box<StockModel>('watchlistBox');

  static List<StockModel> getAllStocks() => _box.values.toList();

  static void addStock({required StockModel stock}) {
    if (!_box.values.any((e) => e.symbol == stock.symbol)) {
      _box.add(stock);
    }
  }

  static void removeStock({required String symbol}) {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k)?.symbol == symbol,
      orElse: () => null,
    );
    if (key != null) {
      _box.delete(key);
    }
  }

  static Future<void> reorderWatchlist(List<StockModel> newOrder) async {
    await _box.clear();
    for (final stock in newOrder) {
      await _box.add(stock);
    }
  }

  static bool isInWatchlist(String symbol) {
    return _box.values.any((e) => e.symbol == symbol);
  }

  static void clearWatchlist() {
    _box.clear();
  }
}
