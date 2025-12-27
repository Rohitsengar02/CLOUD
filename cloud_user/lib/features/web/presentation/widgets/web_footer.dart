import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Info
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_laundry_service, color: Colors.white, size: 32),
                            const SizedBox(width: 12),
                            const Text(
                              'Cloud Wash',
                              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Your trusted partner for premium laundry and dry cleaning services. We prioritize quality, hygiene, and timely delivery.',
                          style: TextStyle(color: Colors.grey.shade400, height: 1.6),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            _SocialIcon(Icons.facebook),
                            _SocialIcon(Icons.camera_alt),
                            _SocialIcon(Icons.alternate_email),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 80),
                  
                  // Quick Links
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Quick Links', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        _FooterLink('Home', onTap: () => context.go('/home')),
                        _FooterLink('About Us', onTap: () => context.go('/about')),
                        _FooterLink('Blog', onTap: () => context.go('/blog')),
                        _FooterLink('My Bookings', onTap: () => context.go('/bookings')),
                        _FooterLink('Reviews', onTap: () => context.go('/reviews')),
                        _FooterLink('Contact', onTap: () => context.go('/contact')),
                      ],
                    ),
                  ),
                  
                  // Services
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Services', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        _FooterLink('Dry Cleaning', onTap: () => context.go('/services')),
                        _FooterLink('Steam Ironing', onTap: () => context.go('/services')),
                        _FooterLink('Shoe Care', onTap: () => context.go('/services')),
                        _FooterLink('Carpet Cleaning', onTap: () => context.go('/services')),
                      ],
                    ),
                  ),
                  
                  // Contact
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Contact Us', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 24),
                        _ContactRow(Icons.phone, '+91 98765 43210'),
                        const SizedBox(height: 16),
                        _ContactRow(Icons.email, 'support@cloudwash.com'),
                        const SizedBox(height: 16),
                        _ContactRow(Icons.location_on, '123, Laundry Lane, Bangalore'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Divider(color: Colors.grey.shade800),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('© 2025 Cloud Wash. All rights reserved.', style: TextStyle(color: Colors.grey.shade600)),
                  Row(
                    children: [
                      _FooterLink('Privacy Policy', onTap: () => context.go('/privacy')),
                      const SizedBox(width: 24),
                      _FooterLink('Terms of Service', onTap: () => context.go('/terms')),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _FooterLink(this.text, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
        ),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _ContactRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
