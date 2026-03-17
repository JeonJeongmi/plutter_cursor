import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String userImage;
  final String postImage;
  final int likes;
  final String caption;

  const PostCard({
    Key? key,
    required this.username,
    required this.userImage,
    required this.postImage,
    required this.likes,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(userImage),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
          // Post Image
          Image.network(
            postImage,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          // Actions
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(Icons.favorite_border, size: 28),
                const SizedBox(width: 15),
                const Icon(Icons.chat_bubble_outline, size: 28),
                const SizedBox(width: 15),
                const Icon(Icons.send, size: 28),
                const Spacer(),
                const Icon(Icons.bookmark_border, size: 28),
              ],
            ),
          ),
          // Likes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$likes likes',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.all(10),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  TextSpan(
                    text: username,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' $caption'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 