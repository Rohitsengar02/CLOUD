import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebNavBar extends ConsumerWidget {
  const WebNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              // Logo
              InkWell(
                onTap: () => context.go('/home'),
                child: Row(
                  children: [
                    Icon(Icons.local_laundry_service, color: Theme.of(context).primaryColor, size: 32),
                    const SizedBox(width: 8),
                    Text(
                      'Cloud Wash',
                      style: TextStyle(
                        fontSize: 24, 
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              // Nav Links (Restored Blog & Reviews)
              _NavLink(label: 'Home', onTap: () => context.go('/home')),
              _NavLink(label: 'About', onTap: () => context.go('/about')),
              _NavLink(label: 'Services', onTap: () => context.go('/services')),
              _NavLink(label: 'Contact', onTap: () => context.go('/contact')),
              
              const Spacer(),
              
              // Search & Profile
              IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.grey)),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => context.push('/profile'),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade100,
                  child: const Icon(Icons.person, color: Colors.grey, size: 20),
                ),
              ),
              const SizedBox(width: 24),

              // Book Now Button (Restored CTA)
              ElevatedButton(
                onPressed: () => context.go('/bookings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 2,
                ),
                child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
