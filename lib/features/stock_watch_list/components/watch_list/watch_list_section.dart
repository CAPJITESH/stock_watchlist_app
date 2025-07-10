import 'package:flutter/material.dart';
import 'package:stock_watch_list/features/stock_watch_list/bloc/stocks_bloc.dart';
import 'package:stock_watch_list/features/stock_watch_list/components/watch_list/watch_list_card.dart';
import 'package:stock_watch_list/features/stock_watch_list/models/stock_model.dart';

class WatchlistSection extends StatelessWidget {
  final List<StockModel> watchlistStocks;
  final StocksBloc stocksBloc;

  const WatchlistSection({
    super.key,
    required this.watchlistStocks,
    required this.stocksBloc,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(
                Icons.visibility,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 10),
              Text(
                'My Watchlist',
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
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '${watchlistStocks.length}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 145,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     itemCount: watchlistStocks.length,
        //     itemBuilder: (context, index) {
        //       final stock = watchlistStocks[index];
        //       return WatchlistCard(
        //         stock: stock,
        //         onRemove: () {
        //           stocksBloc.add(RemoveStockToWatchlist(stockData: stock));
        //           _showSnackBar(
        //             context,
        //             '${stock.symbol} removed from watchlist',
        //             theme.colorScheme.secondary,
        //           );
        //         },
        //       );
        //     },
        //   ),
        // ),
        SizedBox(
          height: 145,
          child: ReorderableListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: watchlistStocks.length,
            itemBuilder: (context, index) {
              final stock = watchlistStocks[index];
              return SizedBox(
                key: ValueKey(stock.symbol),
                width: 160,
                child: WatchlistCard(
                  stock: stock,
                  onRemove: () {
                    stocksBloc.add(RemoveStockToWatchlist(stockData: stock));
                    _showSnackBar(
                      context,
                      '${stock.symbol} removed from watchlist',
                      theme.colorScheme.secondary,
                    );
                  },
                ),
              );
            },
            onReorder: (oldIndex, newIndex) {
              // setState(() {
              //   if (newIndex > oldIndex) newIndex--;
              //   final item = watchlistStocks.removeAt(oldIndex);
              //   watchlistStocks.insert(newIndex, item);
              //   // optionally inform your BLoC of the new order:
              //   // stocksBloc.add(ReorderWatchlist(newOrder: watchlistStocks));
              // });

              stocksBloc.add(
                ReorderStockInWatchList(newIndex: newIndex, oldIndex: oldIndex),
              );
            },
          ),
        ),

        const SizedBox(height: 20),
        Divider(color: theme.dividerColor),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message, Color bgColor) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: textStyle),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
