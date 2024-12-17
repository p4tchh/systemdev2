import 'package:flutter/material.dart';

class MainActivity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Top Profile Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 40.0,
                  color: Colors.grey,
                ),
                SizedBox(width: 8.0),
                Text(
                  "UPCYCLING CONNECT",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {}, // Add favorite action
                  icon: Icon(Icons.star_border),
                ),
                IconButton(
                  onPressed: () {}, // Add notification action
                  icon: Icon(Icons.notifications_none),
                ),
              ],
            ),
          ),

          // Search Section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.lightGreen,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Header Section
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.lightGreen,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Transform your fridge with these DIY polymer clay magnets",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/cutie.png', // Optional image, replace with a placeholder if not used
                  width: 120.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),

          // Category Button Section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CategoryButton(label: "Popular"),
                SizedBox(width: 8.0),
                CategoryButton(label: "New"),
                SizedBox(width: 8.0),
                CategoryButton(label: "Sold Out"),
              ],
            ),
          ),

          // RecyclerView Section Placeholder
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount: 6, // Simulated item count
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: Icon(Icons.image), // Placeholder icon
                      title: Text("Item $index"),
                      subtitle: Text("Item description goes here."),
                    ),
                  );
                },
              ),
            ),
          ),

          // Bottom Navigation Bar
          Container(
            color: Colors.lightGreen,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    // Handle Home navigation
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    // Handle Cart navigation
                  },
                ),
                IconButton(
                  icon: Icon(Icons.star, color: Colors.white),
                  onPressed: () {
                    // Handle Featured navigation
                  },
                ),
                IconButton(
                  icon: Icon(Icons.shopping_bag, color: Colors.white),
                  onPressed: () {
                    // Handle Orders navigation
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline, color: Colors.white),
                  onPressed: () {
                    // Handle Favorites/Chats navigation
                  },
                ),
                IconButton(
                  icon: Icon(Icons.handshake, color: Colors.white),
                  onPressed: () {
                    // Handle Handshake navigation
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;

  const CategoryButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFC7D6B6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        minimumSize: Size(113.0, 40.0),
      ),
      child: Text(
        label,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
