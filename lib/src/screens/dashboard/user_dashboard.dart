import 'package:flutter/material.dart';
import '/src/widgets/profile_menu.dart';
import '/src/widgets/featured_carousel.dart';
import '/src/widgets/notification_menu.dart';
import '/src/widgets/category_section.dart';
import '/src/widgets/cart_section.dart';
import '/src/widgets/orders_section.dart';
import '/src/widgets/chat_section.dart';
import '/src/widgets/tutorials_section.dart';
import '/src/widgets/donations_section.dart';

class MainActivity extends StatefulWidget {
  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    SingleChildScrollView(
      child: Column(
        children: [
          // Search Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search products...",
                  prefixIcon: Icon(Icons.search, color: Colors.lightGreen),
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
            ),
          ),
          const FeaturedCarousel(),
          const CategorySection(),
        ],
      ),
    ),
    CartSection(),
    OrdersSection(),
    ChatSection(),
    TutorialsSection(),
    DonationsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Profile Section with enhanced styling
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.lightGreen.shade200,
                    radius: 20,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierColor: Colors.transparent,
                          builder: (context) => Dialog(
                            alignment: Alignment.topLeft,
                            insetPadding: EdgeInsets.only(top: 70, left: 16),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            child: ProfileMenu(),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.account_circle,
                        size: 30.0,
                        color: Colors.lightGreen.shade700,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Text(
                    "UPCYCLING CONNECT",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen.shade700,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.star_border, color: Colors.amber),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.transparent,
                        builder: (context) => Dialog(
                          alignment: Alignment.topRight,
                          insetPadding: EdgeInsets.only(top: 70, right: 16),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          child: NotificationMenu(),
                        ),
                      );
                    },
                    icon:
                        Icon(Icons.notifications_none, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            Expanded(
              child: _pages[_currentIndex],
            ),

            // Bottom Navigation Bar with enhanced styling
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NavBarIcon(
                    icon: Icons.home,
                    label: "Home",
                    isSelected: _currentIndex == 0,
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                  NavBarIcon(
                    icon: Icons.shopping_cart,
                    label: "Cart",
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                  NavBarIcon(
                    icon: Icons.shopping_bag,
                    label: "Orders",
                    isSelected: _currentIndex == 2,
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                  NavBarIcon(
                    icon: Icons.chat_bubble_outline,
                    label: "Chats",
                    isSelected: _currentIndex == 3,
                    onTap: () => setState(() => _currentIndex = 3),
                  ),
                  NavBarIcon(
                    icon: Icons.school_outlined,
                    label: "Tutorials",
                    isSelected: _currentIndex == 4,
                    onTap: () => setState(() => _currentIndex = 4),
                  ),
                  NavBarIcon(
                    icon: Icons.volunteer_activism,
                    label: "Donations",
                    isSelected: _currentIndex == 5,
                    onTap: () => setState(() => _currentIndex = 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const NavBarIcon({
    required this.icon,
    required this.label,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.lightGreen.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              duration: Duration(milliseconds: 200),
              scale: isSelected ? 1.2 : 1.0,
              child: Icon(
                icon,
                color: isSelected ? Colors.lightGreen : Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.lightGreen : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
