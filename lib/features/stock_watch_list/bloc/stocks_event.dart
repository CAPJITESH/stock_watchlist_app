part of 'stocks_bloc.dart';

@immutable
sealed class StocksEvent {}

final class InitializeAnimationControllers extends StocksEvent {
  final AnimationController animationController;
  final Animation<double> fadeAnimation;

  InitializeAnimationControllers({
    required this.animationController,
    required this.fadeAnimation,
  });
}

final class GetAllStocks extends StocksEvent {}

final class GetAllWatchlistStocks extends StocksEvent {}

final class AddStockToWatchlist extends StocksEvent {
  final StockModel stockData;

  AddStockToWatchlist({required this.stockData});
}

final class RemoveStockToWatchlist extends StocksEvent {
  final StockModel stockData;

  RemoveStockToWatchlist({required this.stockData});
}

final class ReorderStockInWatchList extends StocksEvent {
  final int newIndex, oldIndex;

  ReorderStockInWatchList({required this.newIndex, required this.oldIndex});
}
