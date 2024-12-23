import 'package:flutter/material.dart';

class ChatSection extends StatefulWidget {
  const ChatSection({Key? key}) : super(key: key);

  @override
  State<ChatSection> createState() => _ChatSectionState();
}

class _ChatSectionState extends State<ChatSection>
    with TickerProviderStateMixin {
  final List<Map<String, dynamic>> _chatList = [
    {
      'name': 'Macy',
      'message': 'typing...',
      'isOnline': true,
      'isTyping': true,
      'imageUrl': 'assets/images/profile1.jpg',
    },
    {
      'name': 'Sasha',
      'message': 'typing...',
      'isOnline': true,
      'isTyping': true,
      'imageUrl': 'assets/images/profile2.jpg',
    },
  ];

  final List<Map<String, dynamic>> _contactsList = [
    {
      'name': 'Lalisa Manoban',
      'lastSeen': 'Last seen 2m ago',
      'isOnline': true,
      'imageUrl': 'assets/images/profile1.jpg',
    },
    {
      'name': 'Jennie Kim',
      'lastSeen': 'Last seen 5m ago',
      'isOnline': false,
      'imageUrl': 'assets/images/profile2.jpg',
    },
    {
      'name': 'Roseanne Park',
      'lastSeen': 'Online',
      'isOnline': true,
      'imageUrl': 'assets/images/profile3.jpg',
    },
    {
      'name': 'Kim Jisoo',
      'lastSeen': 'Last seen 1h ago',
      'isOnline': false,
      'imageUrl': 'assets/images/profile4.jpg',
    },
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with tabs
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
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "MESSAGES",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 16),
              TabBar(
                controller: _tabController,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 3,
                    color: Colors.lightGreen.shade700,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                labelColor: Colors.lightGreen.shade700,
                unselectedLabelColor: Colors.grey[600],
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                tabs: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("CHATS"),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text("CONTACTS"),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),

        // Chats/Contacts List with TabBarView
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Chats Tab
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _chatList.length,
                itemBuilder: (context, index) =>
                    _buildChatTile(_chatList[index]),
              ),
              // Contacts Tab
              ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _contactsList.length,
                itemBuilder: (context, index) =>
                    _buildContactTile(_contactsList[index]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChatTile(Map<String, dynamic> chat) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.grey.shade400),
                ),
                if (chat['isOnline'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    chat['message'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: chat['isTyping']
                          ? FontStyle.italic
                          : FontStyle.normal,
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

  Widget _buildContactTile(Map<String, dynamic> contact) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 200),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 10 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
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
            Stack(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person, color: Colors.grey.shade400),
                ),
                if (contact['isOnline'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    contact['lastSeen'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                // Add chat functionality
              },
              icon: Icon(Icons.chat_bubble_outline),
              color: Colors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
