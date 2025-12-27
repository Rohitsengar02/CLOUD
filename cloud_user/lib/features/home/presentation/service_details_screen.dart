import 'package:cloud_user/core/models/service_model.dart';
import 'package:cloud_user/core/theme/app_theme.dart';
import 'package:cloud_user/features/cart/data/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ServiceDetailsScreen extends ConsumerWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: service.image ?? 'https://via.placeholder.com/400',
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => Container(
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.broken_image, size: 64),
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppTheme.warning, size: 20),
                      const SizedBox(width: 4),
                      Text('${service.rating ?? 4.5} (${service.reviewCount ?? 0} reviews)'),
                      const SizedBox(width: 16),
                      const Icon(Icons.schedule, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      Text('${service.duration ?? 60} mins'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '₹${service.price}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service.description ?? 'Professional service delivered by experienced experts. We ensure quality work and customer satisfaction.',
                    style: TextStyle(color: Colors.grey.shade700, height: 1.5),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'What\'s Included',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _IncludedItem(text: 'Professional equipment'),
                  _IncludedItem(text: 'Expert technicians'),
                  _IncludedItem(text: '7-day service warranty'),
                  _IncludedItem(text: 'Free re-service if not satisfied'),

                  const SizedBox(height: 100), // Space for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Price', style: TextStyle(color: Colors.grey)),
                  Text(
                    '₹${service.price}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).addToCart(service);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${service.title} added to cart'),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () => context.push('/cart'),
                      ),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IncludedItem extends StatelessWidget {
  final String text;

  const _IncludedItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppTheme.success, size: 20),
          const SizedBox(width: 12),
          Text(text),
        ],
      ),
    );
  }
}
