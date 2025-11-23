import 'package:flutter/material.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.9);
  bool _showFilterOverlay = false;
  final GlobalKey _filterIconKey = GlobalKey();
  
  // Filter options
  String _sortBy = 'mostRecent';
  Set<String> _selectedLanguages = {};
  Set<String> _selectedDiseases = {};
  
  // Initial filter state
  String _initialSortBy = 'mostRecent';
  Set<String> _initialLanguages = {};
  Set<String> _initialDiseases = {};

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  
  bool get _hasFilterChanges {
    return _sortBy != _initialSortBy ||
           !_selectedLanguages.difference(_initialLanguages).isEmpty ||
           !_initialLanguages.difference(_selectedLanguages).isEmpty ||
           !_selectedDiseases.difference(_initialDiseases).isEmpty ||
           !_initialDiseases.difference(_selectedDiseases).isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFFEFEF1);
    const Color primaryGreen = Color(0xFF099509);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar with menu icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: primaryGreen,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Discover title with filter icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Discover',
                          style: TextStyle(
                            color: primaryGreen,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your daily dose of agri wisdom.',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      key: _filterIconKey,
                      onTap: () {
                        setState(() {
                          _showFilterOverlay = !_showFilterOverlay;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.tune,
                          color: primaryGreen,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Favorites section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Favorites',
                      style: TextStyle(
                        color: Color(0xFF8BC34A),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'View all',
                        style: TextStyle(
                          color: Color(0xFF8BC34A),
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF8BC34A),
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Horizontal scrollable favorites
              SizedBox(
                height: 200,
                child: PageView(
                  controller: _pageController,
                  padEnds: false,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    _FavoriteCard(
                      image: 'assets/images/educ/yellow_flags.jpg',
                      title: 'Yellow Flags: What Rice Yellowing Syndrome Means for Your Crop',
                      author: 'Hernandez, D.',
                      date: 'May 2, 2009',
                    ),
                    _FavoriteCard(
                      image: 'assets/images/educ/rice_field.jpg',
                      title: 'Managing Your Rice Fields',
                      author: 'Santos, M.',
                      date: 'June 15, 2010',
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Dots indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? const Color(0xFF8BC34A)
                          : Colors.grey[400],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // For You section
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'For You',
                  style: TextStyle(
                    color: Color(0xFF8BC34A),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // For You list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _ArticleCard(
                      image: 'assets/images/educ/rice_immunity.jpg',
                      title: 'Simple Ways to Boost Rice Immunity Naturally',
                      author: 'McKinley, A.',
                      date: 'January 27, 2014',
                    ),
                    const SizedBox(height: 16),
                    _ArticleCard(
                      image: 'assets/images/educ/soil_care.jpg',
                      title: 'Proper Soil Care for Stronger Rice Plants',
                      author: 'Junior, Q.',
                      date: 'April 16, 2011',
                    ),
                    const SizedBox(height: 16),
                    _ArticleCard(
                      image: 'assets/images/educ/sheath_blight.jpg',
                      title: 'Hidden Under the Leaves: Detecting Sheath Blight Early',
                      author: 'Campbell, J.',
                      date: 'February 22, 2016',
                    ),
                    const SizedBox(height: 16),
                    _ArticleCard(
                      image: 'assets/images/educ/heat_stress.jpg',
                      title: 'Is It Just Heat Stress or Rice Yellowing Syndrome?',
                      author: 'Kaung, H.',
                      date: 'December 1, 2022',
                    ),
                    const SizedBox(height: 16),
                    _ArticleCard(
                      image: 'assets/images/educ/brown_spot.jpg',
                      title: 'Hidden Under the Leaves: Detecting Sheath Blight Early',
                      author: 'Junior, Q.',
                      date: 'April 16, 2011',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
            ),
          ),
          
          // Filter overlay
          if (_showFilterOverlay)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showFilterOverlay = false;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 120,
                        right: 24,
                        child: GestureDetector(
                          onTap: () {},
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Sort by section
                                  _buildFilterSection(
                                    'Sort By',
                                    [
                                      _buildRadioOption('Most Recent', 'mostRecent'),
                                      _buildRadioOption('Oldest', 'oldest'),
                                    ],
                                  ),
                                  
                                  const Divider(height: 1, color: Color(0xFFE0E0E0)),
                                  
                                  // Language section
                                  _buildFilterSection(
                                    'Language',
                                    [
                                      _buildCheckboxOption('English', 'english'),
                                      _buildCheckboxOption('Filipino', 'filipino'),
                                    ],
                                  ),
                                  
                                  const Divider(height: 1, color: Color(0xFFE0E0E0)),
                                  
                                  // Disease section
                                  _buildFilterSection(
                                    'Disease',
                                    [
                                      _buildCheckboxOption('Rice Yellowing Syndrome', 'yellowing'),
                                      _buildCheckboxOption('Sheath Blight', 'sheath'),
                                      _buildCheckboxOption('Brown Spot Disease', 'brownspot'),
                                    ],
                                  ),
                                  
                                  // Save Changes button
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _hasFilterChanges ? () {
                                          setState(() {
                                            _showFilterOverlay = false;
                                            // Save current state as initial
                                            _initialSortBy = _sortBy;
                                            _initialLanguages = Set.from(_selectedLanguages);
                                            _initialDiseases = Set.from(_selectedDiseases);
                                          });
                                          // TODO: Apply filters to the content
                                        } : null,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: _hasFilterChanges 
                                              ? const Color(0xFFB2E0B2)
                                              : const Color(0xFFBDBDBD),
                                          foregroundColor: _hasFilterChanges
                                              ? const Color(0xFF005300)
                                              : const Color(0xFF424242),
                                          disabledBackgroundColor: const Color(0xFFBDBDBD),
                                          disabledForegroundColor: const Color(0xFF424242),
                                          padding: const EdgeInsets.symmetric(vertical: 12),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                            side: _hasFilterChanges
                                                ? BorderSide.none
                                                : const BorderSide(color: Color(0xFF757575), width: 1),
                                          ),
                                        ),
                                        child: const Text(
                                          'Save Changes',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildFilterSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
  
  Widget _buildRadioOption(String label, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _sortBy = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              _sortBy == value ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              size: 18,
              color: _sortBy == value ? const Color(0xFF099509) : Colors.grey[400],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCheckboxOption(String label, String value) {
    final isLanguage = value == 'english' || value == 'filipino';
    final isSelected = isLanguage 
        ? _selectedLanguages.contains(value)
        : _selectedDiseases.contains(value);
    
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isLanguage) {
            if (_selectedLanguages.contains(value)) {
              _selectedLanguages.remove(value);
            } else {
              _selectedLanguages.add(value);
            }
          } else {
            if (_selectedDiseases.contains(value)) {
              _selectedDiseases.remove(value);
            } else {
              _selectedDiseases.add(value);
            }
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              size: 18,
              color: isSelected ? const Color(0xFF099509) : Colors.grey[400],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String date;

  const _FavoriteCard({
    required this.image,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.green[200],
                child: const Icon(Icons.image, size: 64, color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$author • $date',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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

class _ArticleCard extends StatelessWidget {
  final String image;
  final String title;
  final String author;
  final String date;

  const _ArticleCard({
    required this.image,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.asset(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 100,
                height: 100,
                color: Colors.green[200],
                child: const Icon(Icons.image, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
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
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Icon(
              Icons.bookmark_border,
              color: Colors.green[700],
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
