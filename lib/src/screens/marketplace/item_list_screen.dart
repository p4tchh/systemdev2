import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<dynamic> _items = [];
  bool _isLoading = true;
  Position? _userPosition;

  final List<String> _categories = ['New', 'Popular', 'Nearest'];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _fetchItems();
  }

  Future<void> _getUserLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _userPosition = position;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching location: $e')),
      );
    }
  }

  Future<void> _fetchItems() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _supabase
          .from('items')
          .select('*, profiles(username)')
          .order('created_at', ascending: false);

      if (response != null) {
        setState(() {
          _items = response;
        });
      } else {
        throw Exception('Failed to fetch items.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching items: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000; // Convert to km
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search items...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.lightGreen, width: 2),
              ),
            ),
          ),
        ),

        // Category Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: List.generate(
              _categories.length,
                  (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 0 : 8.0,
                    right: index == _categories.length - 1 ? 0 : 8.0,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedIndex == index
                          ? Colors.lightGreen
                          : Colors.white,
                      foregroundColor: _selectedIndex == index
                          ? Colors.white
                          : Colors.grey[800],
                      elevation: _selectedIndex == index ? 2 : 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: _selectedIndex == index
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        fontWeight: _selectedIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Items Grid
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _items.isEmpty
              ? const Center(child: Text('No items found'))
              : GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) => _buildItemCard(
              _items[index],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItemCard(Map<String, dynamic> item) {
    final uploaderName = item['profiles']['username']; // Username of uploader.
    double? distance;

    if (_userPosition != null &&
        item['latitude'] != null &&
        item['longitude'] != null) {
      distance = _calculateDistance(
        _userPosition!.latitude,
        _userPosition!.longitude,
        item['latitude'],
        item['longitude'],
      );
    }

    return GestureDetector(
      onTap: () {
        debugPrint('Navigating to details of: ${item['name']}');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Item Image Placeholder
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade50,
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: item['images'] != null && item['images'].isNotEmpty
                        ? Image.network(
                      item['images'][0], // Display the first image.
                      fit: BoxFit.cover,
                    )
                        : Icon(
                      Icons.image,
                      size: 64,
                      color: Colors.lightGreen.shade200,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border),
                      color: Colors.grey[600],
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            // Item Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₱${item['price']}',
                    style: const TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '@$uploaderName', // Display the uploader's username.
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  if (distance != null)
                    Text(
                      '${distance.toStringAsFixed(2)} km away',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
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
