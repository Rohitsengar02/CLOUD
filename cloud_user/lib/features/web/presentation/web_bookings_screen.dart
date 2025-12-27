import 'package:cloud_user/features/web/presentation/web_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WebBookingsScreen extends ConsumerWidget {
  const WebBookingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WebLayout(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Bookings', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Panel: Tabs/Filters
                    SizedBox(
                      width: 250,
                      child: Column(
                        children: [
                          _BookingFilterItem(label: 'Ongoing', isSelected: true),
                          _BookingFilterItem(label: 'Completed', isSelected: false),
                          _BookingFilterItem(label: 'Cancelled', isSelected: false),
                        ],
                      ),
                    ),
                    const SizedBox(width: 48),
                    // Right Panel: Empty State (Matching the Urban Prox design)
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_today, size: 80, color: Colors.grey.shade300),
                            const SizedBox(height: 24),
                            const Text('No ongoing bookings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('When you book a service, it will appear here.', style: TextStyle(color: Colors.grey.shade600)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BookingFilterItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _BookingFilterItem({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.pink.withOpacity(0.05) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.pink.withOpacity(0.3)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.pink : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
