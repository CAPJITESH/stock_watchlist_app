import 'package:flutter/material.dart';
import 'package:stock_watch_list/features/stock_watch_list/models/stock_model.dart';

class WatchlistCard extends StatelessWidget {
  final StockModel stock;
  final VoidCallback onRemove;

  const WatchlistCard({super.key, required this.stock, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: theme.dividerColor, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Icon / Logo container
                Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: theme.dividerColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child:
                        stock.iconUrl != null && stock.iconUrl!.isNotEmpty
                            ? Image.network(
                              stock.iconUrl!,
                              width: 45,
                              height: 45,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (_, __, ___) => _placeholderLogo(theme),
                            )
                            : _placeholderLogo(theme),
                  ),
                ),

                // Remove button
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 22,
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Stock symbol
            Text(
              stock.symbol ?? '',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 4),

            // Last traded price
            Text(
              '₹${stock.ltp?.toStringAsFixed(2)}',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholderLogo(ThemeData theme) {
    return Container(
      color: theme.dividerColor.withValues(alpha: 0.2),
      alignment: Alignment.center,
      child: Text(
        stock.symbol?.substring(0, 2) ?? '',
        style: theme.textTheme.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: theme.dividerColor,
        ),
      ),
    );
  }
}
