import 'package:flutter/material.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({Key? key}) : super(key: key);

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {
      'label': 'Popular',
      'items': [
        {'name': 'Recycled Glass Vase', 'price': '₱350'},
        {'name': 'Eco Planter Box', 'price': '₱275'},
        {'name': 'Upcycled Denim Bag', 'price': '₱450'},
        {'name': 'Bamboo Organizer', 'price': '₱299'},
      ]
    },
    {
      'label': 'New',
      'items': [
        {'name': 'Textile Art Frame', 'price': '₱399'},
        {'name': 'Paper Bead Jewelry', 'price': '₱199'},
        {'name': 'Wine Bottle Lamp', 'price': '₱599'},
        {'name': 'Pallet Wood Shelf', 'price': '₱499'},
      ]
    },
    {
      'label': 'Nearest',
      'items': [
        {'name': 'Local Craft Mirror', 'price': '₱289'},
        {'name': 'Handwoven Basket', 'price': '₱349'},
        {'name': 'Recycled Metal Art', 'price': '₱459'},
        {'name': 'Eco-Friendly Coasters', 'price': '₱199'},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category Buttons
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _categories.length,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: index == 1 ? 8.0 : 0.0,
                  ),
                  child: CategoryButton(
                    label: _categories[index]['label'],
                    isSelected: _selectedIndex == index,
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        // Product Grid for selected category
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
          itemCount: _categories[_selectedIndex]['items'].length,
          itemBuilder: (context, index) {
            final item = _categories[_selectedIndex]['items'][index];
            return ProductCard(
              name: item['name'],
              price: item['price'],
            );
          },
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
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

class ProductCard extends StatelessWidget {
  final String name;
  final String price;

  const ProductCard({
    required this.name,
    required this.price,
  });

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
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    price,
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
