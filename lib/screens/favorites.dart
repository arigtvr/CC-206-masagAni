import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFFEFEF1);
    const Color primaryGreen = Color(0xFF099509);

    const List<Map<String, String>> favoriteArticles = [
      {
        'image': 'assets/images/educ/rice_immunity.jpg',
        'title': 'Simple Ways to Boost Rice Immunity Naturally',
        'author': 'McKinley, A.',
        'date': 'January 27, 2014',
      },
      {
        'image': 'assets/images/educ/soil_care.jpg',
        'title': 'Proper Soil Care for Stronger Rice Plants',
        'author': 'Junior, Q.',
        'date': 'April 16, 2011',
      },
      {
        'image': 'assets/images/educ/sheath_blight.jpg',
        'title': 'Hidden Under the Leaves: Detecting Sheath Blight Early',
        'author': 'Campbell, J.',
        'date': 'February 22, 2015',
      },
      {
        'image': 'assets/images/educ/rice_yellowing.jpg',
        'title': 'Is It Just Heat Stress or Rice Yellowing Syndrome?',
        'author': 'Keung, H.',
        'date': 'December 1, 2022',
      },
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: primaryGreen,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Discover',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Favorites title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Text(
                'Favorites',
                style: TextStyle(
                  color: Color(0xFF8BC34A),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // List of favorite articles
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: favoriteArticles.length,
                itemBuilder: (context, index) {
                  final article = favoriteArticles[index];
                  return _FavoriteArticleCard(
                    image: article['image']!,
                    title: article['title']!,
                    author: article['author']!,
                    date: article['date']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteArticleCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String date;

  const _FavoriteArticleCard({
    required this.image,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Article thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 88,
                height: 88,
                color: Colors.green[200],
                child: const Icon(Icons.image, size: 32, color: Colors.white),
              ),
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Article details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '$author  •  $date',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Bookmark icon
          Container(
            margin: const EdgeInsets.only(left: 8),
            child: Icon(
              Icons.bookmark,
              color: const Color(0xFF099509),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
