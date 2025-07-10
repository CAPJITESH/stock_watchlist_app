import 'package:flutter/material.dart';
import 'package:stock_watch_list/features/stock_watch_list/bloc/stocks_bloc.dart';
import 'package:stock_watch_list/features/stock_watch_list/components/all_stocks/all_stocks_card.dart';
import 'package:stock_watch_list/features/stock_watch_list/models/stock_model.dart';

class AllStocksSection extends StatelessWidget {
  final List<StockModel> allStocks;
  final List<StockModel> watchlistStocks;
  final StocksBloc stocksBloc;

  const AllStocksSection({
    super.key,
    required this.allStocks,
    required this.watchlistStocks,
    required this.stocksBloc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: colorScheme.primary, size: 24),
                const SizedBox(width: 10),
                Text(
                  'All Stocks',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${allStocks.length}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: allStocks.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final stock = allStocks[index];
              final isInWatchlist = watchlistStocks.any(
                (w) => w.symbol == stock.symbol,
              );

              return AllStocksCard(
                stock: stock,
                isInWatchlist: isInWatchlist,
                onAdd: () {
                  stocksBloc.add(AddStockToWatchlist(stockData: stock));
                  _showSnackBar(
                    context,
                    '${stock.symbol} added to watchlist',
                    Colors.green,
                  );
                },
                onRemove: () {
                  stocksBloc.add(RemoveStockToWatchlist(stockData: stock));
                  _showSnackBar(
                    context,
                    '${stock.symbol} removed from watchlist',
                    Colors.orange,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color bgColor) {
    final theme = Theme.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: theme.textTheme.bodyMedium),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
