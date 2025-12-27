import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryPink = Color(0xFFE91E63);
    const Color textDark = Color(0xFF1A1D1E);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Bookings',
          style: TextStyle(color: textDark, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: primaryPink,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: primaryPink,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          tabs: const [
            Tab(text: 'Ongoing'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Ongoing Tab
          _buildEmptyState("No ongoing bookings", "Current service requests will be listed here"),
          
          // History Tab (Mocked Data matching Urban design)
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildBookingCard(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today_outlined, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildBookingCard(int index) {
    // Mock Data
    final services = ["Premium Laundry", "Dry Cleaning (Suit)", "Sneaker Care"];
    final dates = ["Sat, 26 Aug", "Wed, 14 Aug", "Mon, 01 Jul"];
    final prices = ["₹499", "₹799", "₹399"];
    final status = index == 0 ? "Completed" : "Cancelled";
    final statusColor = index == 0 ? Colors.green : Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 1)),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Icon (Circle)
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Icon(Icons.local_laundry_service, color: Colors.black87, size: 24),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      services[index],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1D1E)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${dates[index]} • ${prices[index]}",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
              // Status Dot
               Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: statusColor.withOpacity(0.1),
                   borderRadius: BorderRadius.circular(4),
                 ),
                 child: Row(
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Container(width: 6, height: 6, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                     const SizedBox(width: 6),
                     Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               _buildActionButton("Help", false),
               const SizedBox(width: 12),
               _buildActionButton("Reorder", true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, bool isPrimary) {
    const Color primaryPink = Color(0xFFE91E63);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isPrimary ? primaryPink : Colors.transparent,
        border: Border.all(color: isPrimary ? primaryPink : Colors.grey[300]!),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isPrimary ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
