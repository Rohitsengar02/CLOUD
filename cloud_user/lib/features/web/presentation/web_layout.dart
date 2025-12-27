import 'package:cloud_user/core/theme/app_theme.dart';
import 'package:cloud_user/features/web/presentation/widgets/web_footer.dart';
import 'package:cloud_user/features/web/presentation/widgets/web_navbar.dart';
import 'package:flutter/material.dart';

/// Web Layout wrapper - provides navbar + footer for all web pages
class WebLayout extends StatelessWidget {
  final Widget child;
  
  const WebLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Light gray background
      body: Column(
        children: [
          // Top Navigation Bar
          const WebNavBar(),
          
          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Main Content
                  child,
                  
                  // Footer
                  const WebFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
