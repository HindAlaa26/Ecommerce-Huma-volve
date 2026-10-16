import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection_container.dart';
import '../../../core/theme.dart';
import '../cubit/product_details_cubit.dart';
import '../cubit/product_details_state.dart';
import 'product_details_screen.dart';

/// Opens the product details when we only know the product id
/// (e.g. when the app is opened from a deep link).
class ProductDetailsByIdScreen extends StatelessWidget {
  final int productId;

  const ProductDetailsByIdScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductDetailsCubit>()..load(productId),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state.status == ProductDetailsStatus.success &&
              state.product != null) {
            return ProductDetailsScreen(product: state.product!);
          }

          return Scaffold(
            backgroundColor: AppTheme.background,
            appBar: AppBar(),
            body: Center(
              child: state.status == ProductDetailsStatus.failure
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.errorMessage ?? 'Product not found.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 12),
                          TextButton.icon(
                            onPressed: () => context
                                .read<ProductDetailsCubit>()
                                .load(productId),
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator(color: AppTheme.primary),
            ),
          );
        },
      ),
    );
  }
}