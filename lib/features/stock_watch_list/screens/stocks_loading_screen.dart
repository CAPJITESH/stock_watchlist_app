import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

class StocksLoadingScreen extends StatefulWidget {
  const StocksLoadingScreen({super.key});

  @override
  State<StocksLoadingScreen> createState() => _StocksLoadingScreenState();
}

class _StocksLoadingScreenState extends State<StocksLoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildShimmerWatchlistSection(context),
          _buildShimmerAllStocksSection(context),
        ],
      ),
    );
  }

  Widget _buildShimmerWatchlistSection(BuildContext context) {
    final watchlistCount = Random().nextInt(5) + 3;
    final theme = Theme.of(context);

    return Container(
      color: theme.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.visibility, color: theme.primaryColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  'My Watchlist',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(width: 20, height: 15),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: watchlistCount,
              itemBuilder: (context, index) {
                return _buildShimmerWatchlistCard(context);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildShimmerWatchlistCard(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(2, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Shimmer.fromColors(
              baseColor: theme.dividerColor,
              highlightColor: theme.dividerColor.withValues(alpha: 0.5),
              child: Container(
                width: 50,
                height: 16,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Shimmer.fromColors(
              baseColor: theme.dividerColor.withValues(alpha: 0.5),
              highlightColor: theme.dividerColor.withValues(alpha: 0.5),
              child: Container(
                width: 70,
                height: 14,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerAllStocksSection(BuildContext context) {
    final stockCount = Random().nextInt(8) + 5;
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(Icons.trending_up, color: theme.primaryColor, size: 24),
                const SizedBox(width: 10),
                Text(
                  'All Stocks',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: stockCount,
            itemBuilder: (context, index) {
              return _buildShimmerStockItem(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerStockItem(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.dividerColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: theme.dividerColor,
              highlightColor: theme.dividerColor.withValues(alpha: 0.5),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: theme.dividerColor,
                    highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                    child: Container(
                      width: Random().nextDouble() * 80 + 60,
                      height: 16,
                      decoration: BoxDecoration(
                        color: theme.dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Shimmer.fromColors(
                    baseColor: theme.dividerColor,
                    highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                    child: Container(
                      width: Random().nextDouble() * 30 + 30,
                      height: 14,
                      decoration: BoxDecoration(
                        color: theme.dividerColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    width: 80,
                    height: 16,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Shimmer.fromColors(
                  baseColor: theme.dividerColor,
                  highlightColor: theme.dividerColor.withValues(alpha: 0.5),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: theme.dividerColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
