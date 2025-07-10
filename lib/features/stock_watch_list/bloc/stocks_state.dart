part of 'stocks_bloc.dart';

@immutable
sealed class StocksState {}

final class StocksInitial extends StocksState {}

final class StocksLoading extends StocksState {}

final class NoStocksFound extends StocksState {}

final class StocksSuccess extends StocksState {
  final List<StockModel> allStocks;
  final List<StockModel> watchlistStocks;

  StocksSuccess({required this.allStocks, required this.watchlistStocks});

  StocksSuccess copyWith({
    List<StockModel>? allStocks,
    List<StockModel>? watchlistStocks,
  }) {
    return StocksSuccess(
      allStocks: allStocks ?? this.allStocks,
      watchlistStocks: watchlistStocks ?? this.watchlistStocks,
    );
  }
}

final class StocksError extends StocksState {}
