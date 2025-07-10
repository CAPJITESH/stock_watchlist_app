import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_watch_list/features/stock_watch_list/bloc/stocks_bloc.dart';
import 'package:stock_watch_list/features/stock_watch_list/components/all_stocks/all_stocks_section.dart';
import 'package:stock_watch_list/features/stock_watch_list/components/watch_list/watch_list_section.dart';
import 'package:stock_watch_list/features/stock_watch_list/screens/stocks_loading_screen.dart';

class WatchlistScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  const WatchlistScreen({super.key, required this.onToggleTheme});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;

  final StocksBloc stocksBloc = StocksBloc();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    stocksBloc.add(
      InitializeAnimationControllers(
        animationController: animationController,
        fadeAnimation: fadeAnimation,
      ),
    );

    stocksBloc.add(GetAllStocks());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Stocks App',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: BlocBuilder<StocksBloc, StocksState>(
        bloc: stocksBloc,
        builder: (context, state) {
          if (state is StocksLoading) {
            return const StocksLoadingScreen();
          }

          if (state is StocksError) {
            return Center(
              child: Text(
                'Error loading stocks',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.error,
                  fontSize: 18,
                ),
              ),
            );
          }

          if (state is StocksSuccess) {
            return FadeTransition(
              opacity: fadeAnimation,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state.watchlistStocks.isNotEmpty)
                      WatchlistSection(
                        watchlistStocks: state.watchlistStocks,
                        stocksBloc: stocksBloc,
                      ),
                    AllStocksSection(
                      allStocks: state.allStocks,
                      watchlistStocks: state.watchlistStocks,
                      stocksBloc: stocksBloc,
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
