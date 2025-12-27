import 'package:cloud_user/core/theme/app_theme.dart';
import 'package:cloud_user/features/web/presentation/web_layout.dart';
import 'package:flutter/material.dart';

/// Static page types
enum StaticPageType {
  aboutUs,
  terms,
  privacy,
  contactUs,
  blog,
  reviews,
}

class WebStaticPage extends StatelessWidget {
  final StaticPageType pageType;

  const WebStaticPage({super.key, required this.pageType});

  @override
  Widget build(BuildContext context) {
    final pageData = _getPageData(pageType);
    // Use wider layout for blog page
    final isWideLayout = pageType == StaticPageType.blog || pageType == StaticPageType.reviews;

    return WebLayout(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWideLayout ? 1100 : 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pageData.title,
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 32),
                pageData.content,
              ],
            ),
          ),
        ),
      ),
    );
  }

  _PageData _getPageData(StaticPageType type) {
    switch (type) {
      case StaticPageType.aboutUs:
        return _PageData(
          title: 'About Cloud Wash',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph(
                'Cloud Wash is India\'s premier laundry and dry cleaning service, providing doorstep pickup and delivery '
                'across major cities. Founded in 2024, our mission is to make laundry day hassle-free with professional ' 
                'garment care using world-class German eco-friendly solutions.',
              ),
              _paragraph(
                'What defines us is our commitment to quality. Every garment goes through our 6-stage care process - '
                'Sorting, Stain Treatment, Processing, Finishing, Quality Check, and Packing.',
              ),
              _heading('Our Vision'),
              _paragraph(
                'To be India\'s most trusted laundry brand, delivering fresh, clean clothes with care and convenience.',
              ),
              _heading('Our Mission'),
              _paragraph(
                'Provide professional laundry, dry cleaning, and specialty cleaning services with free pickup & delivery.',
              ),
              _heading('Our Services'),
              _paragraph(
                '• Laundry (Wash & Fold, Wash & Steam Iron)\n'
                '• Dry Cleaning (Designer Wear, Woollens, Silk)\n'
                '• Shoe Cleaning & Restoration\n'
                '• Leather Cleaning (Bags, Jackets, Belts)\n'
                '• Curtain & Carpet Cleaning',
              ),
            ],
          ),
        );

      case StaticPageType.terms:
        return _PageData(
          title: 'Terms & Conditions',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph('Last Updated: December 2024'),
              _heading('1. Introduction'),
              _paragraph(
                'Welcome to Cloud Wash. By using our website and app, you agree to these terms.',
              ),
              _heading('2. Service Bookings'),
              _paragraph(
                'Bookings are subject to professional availability. Cancellation fees may apply if cancelled within 2 hours of the scheduled time.',
              ),
              _heading('3. Payments'),
              _paragraph(
                'We accept credit cards, UPI, and cash. All payments are processed securely.',
              ),
              _heading('4. Liability'),
              _paragraph(
                'Cloud Wash facilitates the connection between customers and service providers. We are not liable for any damages caused during service delivery.',
              ),
            ],
          ),
        );

      case StaticPageType.privacy:
        return _PageData(
          title: 'Privacy Policy',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph(
                'Your privacy is important to us. This policy outlines how we collect, use, and protect your data.',
              ),
              _heading('Data Collection'),
              _paragraph(
                'We collect your name, phone number, and address to facilitate service delivery. Location data is used to match you with nearby professionals.',
              ),
              _heading('Data Security'),
              _paragraph(
                'We use industry-standard encryption to protect your personal information. We do not sell your data to third parties.',
              ),
              _heading('Your Rights'),
              _paragraph(
                'You have the right to access, correct, or delete your personal data at any time.',
              ),
            ],
          ),
        );

      case StaticPageType.contactUs:
        return _PageData(
          title: 'Contact Us',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph('We\'d love to hear from you. Reach out to us for any queries or feedback.'),
              const SizedBox(height: 24),
              _contactItem(Icons.email_outlined, 'Email', 'help@cloudwash.com'),
              _contactItem(Icons.phone_outlined, 'Phone', '+91 1800-123-4567'),
              _contactItem(Icons.location_on_outlined, 'Office', 'Cloud Wash HQ, Indiranagar, Bangalore, 560038'),
              const SizedBox(height: 32),
              _heading('Business Hours'),
              _paragraph('Monday - Saturday: 8:00 AM - 9:00 PM\nSunday: 9:00 AM - 6:00 PM'),
            ],
          ),
        );

      case StaticPageType.blog:
        return _PageData(
          title: 'Cloud Wash Blog',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph('Tips, tricks, and insights for garment care and laundry.'),
              const SizedBox(height: 32),
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  SizedBox(
                    width: 520,
                    child: _blogCard('How to Keep Your White Clothes Bright', 'Expert tips on maintaining the brightness of your white garments and removing stubborn stains...', 'https://images.unsplash.com/photo-1582735689369-4fe89db7114c?w=600'),
                  ),
                  SizedBox(
                    width: 520,
                    child: _blogCard('The Ultimate Guide to Dry Cleaning', 'When should you dry clean vs wash? Learn what fabrics need professional care...', 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600'),
                  ),
                  SizedBox(
                    width: 520,
                    child: _blogCard('5 Tips to Make Your Shoes Last Longer', 'Proper shoe care can extend the life of your favorite footwear. Here\'s how...', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600'),
                  ),
                  SizedBox(
                    width: 520,
                    child: _blogCard('Caring for Leather: Bags, Jackets & More', 'Professional tips for maintaining your leather goods and keeping them looking new...', 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=600'),
                  ),
                ],
              ),
            ],
          ),
        );

      case StaticPageType.reviews:
        return _PageData(
          title: 'Customer Reviews',
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _paragraph('See what our happy customers have to say about our laundry services.'),
              const SizedBox(height: 24),
              _reviewCard(5, '"Excellent laundry service! My clothes came back perfectly folded and smelling fresh. The pickup was right on time."', 'Priya S., Bangalore'),
              _reviewCard(5, '"Best dry cleaning I\'ve ever used. My silk sarees look brand new!"', 'Deepika R., Mumbai'),
              _reviewCard(5, '"Amazing shoe cleaning service. My white sneakers look spotless now. Highly recommend!"', 'Rahul K., Delhi'),
              _reviewCard(5, '"The curtain cleaning was fantastic. They handled my delicate curtains with care."', 'Meera P., Hyderabad'),
              _reviewCard(4, '"Great carpet cleaning! Removed all the stains and the carpet smells fresh."', 'Amit S., Chennai'),
            ],
          ),
        );
    }
  }

  Widget _paragraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          height: 1.6,
          color: Colors.grey.shade700,
        ),
      ),
    );
  }

  Widget _heading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _contactItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: AppTheme.primary),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _blogCard(String title, String snippet, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 180,
                color: Colors.grey.shade200,
                child: Center(child: Icon(Icons.image, size: 50, color: Colors.grey.shade400)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(snippet, style: TextStyle(color: Colors.grey.shade600, height: 1.5)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Read More', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(int stars, String review, String reviewer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (i) => Icon(
              i < stars ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 20,
            )),
          ),
          const SizedBox(height: 12),
          Text(review, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey.shade700)),
          const SizedBox(height: 8),
          Text('- $reviewer', style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _PageData {
  final String title;
  final Widget content;
  _PageData({required this.title, required this.content});
}
