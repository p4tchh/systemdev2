import 'package:flutter/material.dart';
import '/src/widgets/profile_menu.dart';
import '/src/widgets/featured_carousel.dart';

class MainActivity extends StatelessWidget {
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
                    onPressed: () {},
                    icon:
                        Icon(Icons.notifications_none, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                children: [
                  // Search Section with enhanced styling
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
                          prefixIcon:
                              Icon(Icons.search, color: Colors.lightGreen),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 14.0),
                        ),
                      ),
                    ),
                  ),

                  // Featured Carousel Section
                  const FeaturedCarousel(),

                  // Category Buttons with enhanced styling
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CategoryButton(
                            label: "Popular",
                            isSelected: true,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: CategoryButton(
                            label: "New",
                            isSelected: false,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: CategoryButton(
                            label: "Sold Out",
                            isSelected: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Product Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return ProductCard();
                    },
                  ),
                ],
              ),
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
                  NavBarIcon(icon: Icons.home, label: "Home", isSelected: true),
                  NavBarIcon(icon: Icons.shopping_cart, label: "Cart"),
                  NavBarIcon(icon: Icons.star, label: "Featured"),
                  NavBarIcon(icon: Icons.shopping_bag, label: "Orders"),
                  NavBarIcon(icon: Icons.chat_bubble_outline, label: "Chats"),
                  NavBarIcon(icon: Icons.handshake, label: "Deals"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryButton({
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.lightGreen : Colors.white,
        foregroundColor: isSelected ? Colors.white : Colors.grey[800],
        elevation: isSelected ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class NavBarIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const NavBarIcon({
    required this.icon,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.lightGreen : Colors.grey[600],
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? Colors.lightGreen : Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade50,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 64,
                  color: Colors.lightGreen.shade200,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Cloud Tulip Mirror",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "₱257",
                    style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
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
}
