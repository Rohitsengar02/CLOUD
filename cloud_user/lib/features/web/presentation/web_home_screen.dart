import 'package:cloud_user/core/theme/app_theme.dart';
import 'package:cloud_user/features/home/data/home_providers.dart';
import 'package:cloud_user/features/web/presentation/web_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WebHomeScreen extends ConsumerStatefulWidget {
  const WebHomeScreen({super.key});

  @override
  ConsumerState<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends ConsumerState<WebHomeScreen> {
  
  // Category icon mapping
  IconData _getCategoryIcon(String name) {
    switch (name.toLowerCase()) {
      case 'laundry': return Icons.local_laundry_service;
      case 'dry cleaning': return Icons.dry_cleaning;
      case 'shoe cleaning': return Icons.sports_handball;
      case 'leather cleaning': return Icons.work_outline;
      case 'curtain cleaning': return Icons.curtains;
      case 'carpet cleaning': return Icons.texture;
      default: return Icons.local_laundry_service;
    }
  }

  Color _getCategoryColor(int index) {
    final colors = [
      const Color(0xFFE3F2FD),
      const Color(0xFFFFF3E0),
      const Color(0xFFE8F5E9),
      const Color(0xFFFCE4EC),
      const Color(0xFFE0F7FA),
      const Color(0xFFF3E5F5),
      const Color(0xFFFFF8E1),
      const Color(0xFFE0F2F1),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Stack(
      children: [
        WebLayout(
          child: Column(
            children: [
              _buildHeroSection(context),
              _buildCategoriesSection(context, categoriesAsync),
              _buildSpotlightSection(context),
              _buildOffersSection(context),
              _buildMostBookedSection(context),
              _buildHowItWorksSection(context), // 6-stage process (Pink BG)
              _buildMoreReasonsSection(context), // More reasons (Yellow BG)
              _buildWhyChooseUsSection(context),
              _buildTestimonialsSection(context),
              _buildStatsAndDownloadSection(context),
            ],
          ),
        ),
        Positioned(
          bottom: 30,
          right: 30,
          child: _buildFloatingWhatsAppButton(),
        ),
      ],
    );
  }

  // --- Sections ---

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primary.withOpacity(0.05), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppTheme.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 16, color: AppTheme.success),
                          const SizedBox(width: 8),
                          Text(
                            '4.8/5 Rated Professionals',
                            style: TextStyle(color: AppTheme.success, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Premium Laundry &\nDry Cleaning',
                      style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, height: 1.1, color: AppTheme.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    Text('At Your Doorstep • Free Pickup & Delivery', style: TextStyle(fontSize: 20, color: Colors.grey.shade600)),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF1976D2), Color(0xFF42A5F5)]),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('🎉 Flat 20% OFF on First Order!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _FeatureBadge(icon: Icons.local_shipping, text: 'Free Pickup'),
                        const SizedBox(width: 16),
                        _FeatureBadge(icon: Icons.flash_on, text: '24Hr Express'),
                        const SizedBox(width: 16),
                        _FeatureBadge(icon: Icons.eco, text: 'Eco-Friendly'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: Colors.grey.shade400, size: 24),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search for 'Laundry', 'Dry Cleaning'...",
                                hintStyle: TextStyle(color: Colors.grey.shade400),
                                border: InputBorder.none,
                              ),
                              onSubmitted: (query) { if (query.isNotEmpty) context.push('/services'); },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Text('Trending: ', style: TextStyle(color: Colors.grey.shade600)),
                        _TrendingTag('Laundry', () => context.push('/category/1', extra: 'Laundry')),
                        _TrendingTag('Dry Cleaning', () => context.push('/category/2', extra: 'Dry Cleaning')),
                        _TrendingTag('Shoe Cleaning', () => context.push('/category/3', extra: 'Shoe Cleaning')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://res.cloudinary.com/dms3qxrd2/image/upload/v1766748447/cloudwash_j3rnfa.jpg',
                    height: 500,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 500,
                      color: Colors.grey.shade200,
                      child: const Center(child: Icon(Icons.image, size: 100, color: Colors.grey)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, AsyncValue<List<dynamic>> categoriesAsync) {
    final mockCategories = [
      {'name': 'Laundry', 'id': '1', 'subtitle': 'Wash & Fold | Wash & Steam Iron'},
      {'name': 'Dry Cleaning', 'id': '2', 'subtitle': 'Designer Wear, Heavy Ethnic Wear'},
      {'name': 'Shoe Cleaning', 'id': '3', 'subtitle': 'Shoe Cleaning, Restoration'},
      {'name': 'Leather Cleaning', 'id': '4', 'subtitle': 'Bags, Jackets, Wallets'},
      {'name': 'Curtain Cleaning', 'id': '5', 'subtitle': 'Silk, Cotton, Velvet'},
      {'name': 'Carpet Cleaning', 'id': '6', 'subtitle': 'Persian, Silk, Turkish'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('All Categories', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => context.push('/services'),
                    child: Row(
                      children: [
                        Text('View All', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.w600)),
                        Icon(Icons.arrow_forward, size: 16, color: AppTheme.primary),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              categoriesAsync.when(
                data: (categories) => Wrap(
                  spacing: 24, runSpacing: 24,
                  children: (categories.isEmpty ? mockCategories : categories).asMap().entries.map((entry) {
                    final category = entry.value;
                    final name = category is Map ? category['name'] as String : category.name;
                    final id = category is Map ? category['id'] as String : category.id;
                    return _CategoryCard(
                      name: name,
                      icon: _getCategoryIcon(name),
                      bgColor: _getCategoryColor(entry.key),
                      onTap: () => context.push('/category/$id', extra: name),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Wrap(
                  spacing: 24, runSpacing: 24,
                  children: mockCategories.asMap().entries.map((entry) {
                    return _CategoryCard(
                      name: entry.value['name']!,
                      icon: _getCategoryIcon(entry.value['name']!),
                      bgColor: _getCategoryColor(entry.key),
                      onTap: () => context.push('/category/${entry.value['id']}', extra: entry.value['name']),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 6 Stage Process (RE-DESIGNED TO MATCH SCREENSHOT EXACTLY)
  Widget _buildHowItWorksSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFFEF2F2), // Light Pink background from design
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Text and Buttons
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '6 STAGE PROCESS FOR\nUNMATCHED GARMENT CARE',
                      style: TextStyle(
                        fontSize: 32, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFFBC8E8E), // Reddish-pink title
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(width: 400, height: 1.5, color: Colors.grey.shade300),
                    const SizedBox(height: 20),
                    const Text(
                      'Specialized Machinery & Skilled Experts for each stage makes us the best laundry & dry cleaner near you.',
                      style: TextStyle(fontSize: 18, color: Color(0xFF4A4A4A), height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    Container(width: 400, height: 1.5, color: Colors.grey.shade300),
                    const SizedBox(height: 48),
                    const Text('To Place Your Order', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _ProcessButton(text: 'Chat On WhatsApp', color: const Color(0xFFD8A0A0)),
                        const SizedBox(width: 12),
                        _ProcessButton(text: 'Schedule Free Pickup', color: const Color(0xFFD8A0A0)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 80),
              // Right side: Vertical Timeline
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    _TimelineItem(1, 'Sorting & Inspection', 'Segregation basis care label, fabric type and color'),
                    _TimelineItem(2, 'Stain Treatment', 'Italian spotting machines | American stain removing solutions'),
                    _TimelineItem(3, 'Processing', 'World-Renowned Italian Dry cleaning machines | German Eco friendly cleaning solutions'),
                    _TimelineItem(4, 'Finishing', 'Unique Steam Ironing equipment for each garment type'),
                    _TimelineItem(5, 'Quality Check', 'Meticulous inspection of each item by experts'),
                    _TimelineItem(6, 'Packing', 'Folded, Hanger or Vacuum packing as per your stated preference'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // More Reasons (RE-DESIGNED TO MATCH SCREENSHOT EXACTLY)
  Widget _buildMoreReasonsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFF8FBEF), // Light Yellow/Green background from design
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              // Left side: Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MORE REASONS TO EXPERIENCE\nOUR SERVICES',
                      style: TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF8A8DBA), // Purple/Violet title
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(width: 500, height: 1.5, color: Colors.grey.shade300),
                    const SizedBox(height: 24),
                    const _ReasonRow('Flat 20% Off On 1st Order'),
                    const _ReasonRow('Attractive Membership Plans'),
                    const _ReasonRow('Free Pick up & Drop'),
                    const SizedBox(height: 16),
                    Container(width: 500, height: 1.5, color: Colors.grey.shade300),
                    const SizedBox(height: 48),
                    const Text('Explore our Pricing & Offers', style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              // Right side: Image (Happy Woman with Laundry)
              Expanded(
                child: Center(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1549439602-43ebca2327af?w=600', // Image of person with clean clothes
                    height: 400,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 200, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpotlightSection(BuildContext context) {
    final spotlightItems = [
      {'title': 'Express Laundry', 'subtitle': '24 Hour Delivery', 'color': const Color(0xFFE3F2FD), 'icon': Icons.local_laundry_service, 'textColor': const Color(0xFF1565C0)},
      {'title': 'Premium Dry Clean', 'subtitle': 'Designer Wear Care', 'color': const Color(0xFFFCE4EC), 'icon': Icons.dry_cleaning, 'textColor': const Color(0xFFC2185B)},
      {'title': 'Shoe Spa', 'subtitle': 'Restore & Protect', 'color': const Color(0xFFFFF3E0), 'icon': Icons.sports_handball, 'textColor': const Color(0xFFE65100)},
      {'title': 'Carpet Care', 'subtitle': 'Deep Clean', 'color': const Color(0xFFE8F5E9), 'icon': Icons.texture, 'textColor': const Color(0xFF2E7D32)},
      {'title': 'Curtain Fresh', 'subtitle': 'Free Pickup', 'color': const Color(0xFFE0F7FA), 'icon': Icons.curtains, 'textColor': const Color(0xFF00838F)},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: const Color(0xFFF7F8FA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('In the Spotlight', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              Row(
                children: spotlightItems.map((item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _SpotlightCard(
                      title: item['title'] as String,
                      subtitle: item['subtitle'] as String,
                      color: item['color'] as Color,
                      icon: item['icon'] as IconData,
                      textColor: item['textColor'] as Color,
                      onTap: () => context.push('/category/1', extra: item['title']),
                    ),
                  ),
                )).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffersSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Offers & Discounts', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              Row(
                children: [
                   _OfferCard(Colors.blue, 'Laundry Special', '20% OFF'),
                   const SizedBox(width: 16),
                   _OfferCard(Colors.purple, 'New User', '₹100 OFF'),
                   const SizedBox(width: 16),
                   _OfferCard(Colors.green, 'Dry Clean', '30% OFF'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMostBookedSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: const Color(0xFFF7F8FA),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Most Booked Services', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(child: _buildSimpleServiceCard('Wash & Fold', 49, 4.8, 'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?w=400')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildSimpleServiceCard('Dry Cleaning', 149, 4.9, 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildSimpleServiceCard('Shoe Cleaning', 299, 4.7, 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleServiceCard(String name, int price, double rating, String imageUrl) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(borderRadius: const BorderRadius.vertical(top: Radius.circular(16)), child: Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Text('₹$price', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold, fontSize: 18)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyChooseUsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text('Why Choose Us', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const Text('We provide the best care for your garments', style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 60),
              Row(
                children: [
                   Expanded(child: _WhyChooseItem(icon: Icons.verified, title: 'Quality Assurance', subtitle: 'Highest quality standards for your clothes')),
                   Expanded(child: _WhyChooseItem(icon: Icons.access_time, title: 'On Time Delivery', subtitle: 'We respect your time and schedule')),
                   Expanded(child: _WhyChooseItem(icon: Icons.eco, title: 'Eco Friendly', subtitle: 'Sustainable practices and non-toxic solvents')),
                   Expanded(child: _WhyChooseItem(icon: Icons.attach_money, title: 'Affordable Pricing', subtitle: 'Premium service at competitive rates')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: const Color(0xFFF7F8FA),
      child: Center(
         child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const Text('What Our Customers Say', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
               const SizedBox(height: 60),
               Row(
                 children: [
                   Expanded(child: _TestimonialCard(name: 'Sarah J.', location: 'Mumbai', rating: 5, text: 'Absolutely love the service! My clothes have never looked better. The pickup and delivery is super convenient.')),
                   const SizedBox(width: 24),
                   Expanded(child: _TestimonialCard(name: 'Rahul M.', location: 'Bangalore', rating: 5, text: 'The 6 stage process really makes a difference. Stains I thought were permanent are gone. Highly recommended!')),
                   const SizedBox(width: 24),
                   Expanded(child: _TestimonialCard(name: 'Priya S.', location: 'Delhi', rating: 4, text: 'Great app experience and very professional staff. The real-time tracking helps me plan my day better.')),
                 ],
               ),
            ],
          ),
         ),
      ),
    );
  }

  Widget _buildStatsAndDownloadSection(BuildContext context) {
    final stats = [
      {'value': '50K+', 'label': 'Happy Customers'},
      {'value': '1000+', 'label': 'Verified Professionals'},
      {'value': '20+', 'label': 'Cities'},
      {'value': '4.8', 'label': 'Average Rating'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: stats.map((s) => Column(
                  children: [
                    Text(s['value']!, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(s['label']!, style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9))),
                  ],
                )).toList(),
              ),
            ),
          ),
          const SizedBox(height: 80),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text('📱 Mobile App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Get the Cloud Wash App',
                          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Schedule laundry pickups, track orders in real-time, and enjoy exclusive app-only discounts!',
                          style: TextStyle(fontSize: 18, color: Colors.white.withOpacity(0.9), height: 1.6),
                        ),
                       const SizedBox(height: 32),
                       Row(
                         children: [
                            _AppStoreBadge(icon: Icons.apple, text: 'App Store'),
                            const SizedBox(width: 16),
                            _AppStoreBadge(icon: Icons.android, text: 'Google Play'),
                         ],
                       ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 60),
                  Container(
                    width: 280,
                    height: 500,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 30, offset: const Offset(0, 20))],
                    ),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1512428559087-560fa5ceab42?w=600', // Cleaner phone UI stock image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingWhatsAppButton() {
    return Container(
      width: 60, height: 60,
      decoration: BoxDecoration(color: const Color(0xFF25D366), borderRadius: BorderRadius.circular(30)),
      child: const Icon(Icons.chat, color: Colors.white, size: 28),
    );
  }
}

// Helper Widgets
class _FeatureBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _FeatureBadge({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(icon, size: 20, color: AppTheme.success), const SizedBox(width: 8), Text(text)]);
  }
}

class _TrendingTag extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _TrendingTag(this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), margin: const EdgeInsets.only(right: 8), decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)), child: Text(text)));
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color bgColor;
  final VoidCallback onTap;
  const _CategoryCard({required this.name, required this.icon, required this.bgColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(width: 200, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 40), const SizedBox(height: 12), Text(name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))])),
    );
  }
}

class _SpotlightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final Color textColor;
  final VoidCallback onTap;
  const _SpotlightCard({required this.title, required this.subtitle, required this.color, required this.icon, required this.textColor, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, color: textColor), const SizedBox(height: 12), Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)), Text(subtitle, style: TextStyle(color: textColor.withOpacity(0.8), fontSize: 12))])));
  }
}

class _OfferCard extends StatelessWidget {
  final Color color;
  final String title;
  final String offer;
  const _OfferCard(this.color, this.title, this.offer, {super.key});
  @override
  Widget build(BuildContext context) {
     return Expanded(child: Container(height: 150, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text(offer, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))])));
  }
}

class _TimelineItem extends StatelessWidget {
  final int number;
  final String title;
  final String desc;
  const _TimelineItem(this.number, this.title, this.desc);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36, height: 36,
            decoration: const BoxDecoration(color: Color(0xFF4AC3F5), shape: BoxShape.circle),
            child: Center(child: Text('$number', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF4A4A4A))),
                Text(desc, style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProcessButton extends StatelessWidget {
  final String text;
  final Color color;
  const _ProcessButton({required this.text, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }
}

class _ReasonRow extends StatelessWidget {
  final String text;
  const _ReasonRow(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF4A4A4A))),
    );
  }
}

class _WhyChooseItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _WhyChooseItem({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) { return Column(children: [Icon(icon, size: 40, color: AppTheme.primary), const SizedBox(height: 16), Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey))]); }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String location;
  final int rating;
  final String text;
  const _TestimonialCard({required this.name, required this.location, required this.rating, required this.text});
  @override
  Widget build(BuildContext context) { return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]), child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(5, (index) => Icon(index < rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 20))), const SizedBox(height: 16), Text('"$text"', textAlign: TextAlign.center, style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 14)), const SizedBox(height: 16), Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(location, style: const TextStyle(fontSize: 12, color: Colors.grey))])); }
}

class _AppStoreBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _AppStoreBadge({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) { return Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)), child: Row(children: [Icon(icon, color: Colors.black), const SizedBox(width: 8), Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))])); }
}
