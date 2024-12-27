import 'package:flutter/material.dart';

void showItemDetailsPopup(
    BuildContext context, Map<String, dynamic> item, double? distance) {
  final uploaderName = item['profiles']['username'];
  final uploaderProfilePicture = item['profiles']['profile_image_url'];

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Item Image
              if (item['images'] != null && item['images'].isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    item['images'][0],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.grey.shade200,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Name and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '₱${item['price']}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item['description'] ?? 'No description provided.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Uploader Profile
              const Text(
                'Uploaded By:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  if (uploaderProfilePicture != null)
                    ClipOval(
                      child: Image.network(
                        uploaderProfilePicture,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person, size: 25),
                    ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@$uploaderName',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (distance != null)
                        Text(
                          '${distance.toStringAsFixed(2)} km away',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                  const Spacer(),
                  // Chat Icon
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Navigate to Chat Page
                      Navigator.pop(context); // Close popup
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chat feature coming soon!')),
                      );
                    },
                  ),
                  // View Profile Icon
                  IconButton(
                    icon: const Icon(Icons.person_outline),
                    color: Colors.lightGreen,
                    onPressed: () {
                      // Navigate to Profile Page
                      Navigator.pop(context); // Close popup
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('View Profile feature coming soon!')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
    },
  );
}
