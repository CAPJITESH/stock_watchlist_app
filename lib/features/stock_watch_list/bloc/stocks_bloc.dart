import 'dart:async';
import 'dart:convert';

import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_watch_list/features/stock_watch_list/models/stock_model.dart';
import 'package:stock_watch_list/features/stock_watch_list/services/watchlist_service.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

class StocksBloc extends Bloc<StocksEvent, StocksState> {
  StocksBloc() : super(StocksInitial()) {
    // For initialization of Controllers
    on<InitializeAnimationControllers>(initializeAnimationControllers);

    // For getting Data
    on<GetAllStocks>(getAllStocks);

    // CRUD operations of Stocks Wih
    on<AddStockToWatchlist>(addStockToWatchlist);
    on<RemoveStockToWatchlist>(removeStockToWatchlist);

    //for Reordering WatchList
    on<ReorderStockInWatchList>(reorderStockInWatchList);
  }

  List<StockModel> allStocksList = [];
  List<StockModel> watchlistStocksList = [];
  late AnimationController _animationController;

  FutureOr<void> initializeAnimationControllers(
    InitializeAnimationControllers event,
    Emitter<StocksState> emit,
  ) {
    _animationController = event.animationController;
  }

  FutureOr<void> getAllStocks(
    GetAllStocks event,
    Emitter<StocksState> emit,
  ) async {
    try {
      emit(StocksLoading());

      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));

      final String jsonString = await rootBundle.loadString(
        'assets/data/stocks.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);

      allStocksList = jsonData.map((e) => StockModel.fromJson(e)).toList();

      watchlistStocksList = WatchlistService.getAllStocks();

      _animationController.forward();

      emit(
        StocksSuccess(
          allStocks: allStocksList,
          watchlistStocks: watchlistStocksList,
        ),
      );
    } catch (e) {
      debugPrint('Error loading stocks: $e');
      emit(StocksError());
    }
  }

  FutureOr<void> addStockToWatchlist(
    AddStockToWatchlist event,
    Emitter<StocksState> emit,
  ) {
    if (state is StocksSuccess) {
      watchlistStocksList.add(event.stockData);
      WatchlistService.addStock(stock: event.stockData);

      emit(
        (state as StocksSuccess).copyWith(watchlistStocks: watchlistStocksList),
      );
    }
  }

  FutureOr<void> removeStockToWatchlist(
    RemoveStockToWatchlist event,
    Emitter<StocksState> emit,
  ) {
    if (state is StocksSuccess) {
      watchlistStocksList.remove(event.stockData);
      WatchlistService.removeStock(symbol: event.stockData.symbol!);

      emit(
        (state as StocksSuccess).copyWith(watchlistStocks: watchlistStocksList),
      );
    }
  }

  FutureOr<void> reorderStockInWatchList(
    ReorderStockInWatchList event,
    Emitter<StocksState> emit,
  ) async {
    if (state is StocksSuccess) {
      int newIndex = event.newIndex, oldIndex = event.oldIndex;
      final oldIndexStock = watchlistStocksList[oldIndex];
      watchlistStocksList.removeAt(oldIndex);
      if (newIndex > oldIndex) newIndex--;

      watchlistStocksList.insert(newIndex, oldIndexStock);

      emit(
        (state as StocksSuccess).copyWith(watchlistStocks: watchlistStocksList),
      );

      await WatchlistService.reorderWatchlist(watchlistStocksList);
    }
  }
}
