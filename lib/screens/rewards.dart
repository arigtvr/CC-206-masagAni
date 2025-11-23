import 'package:flutter/material.dart';
import 'profile.dart';
import 'claim_history.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = Color(0xFFFEFEF1);
    const Color primaryGreen = Color(0xFF099509);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar with back button and history icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: primaryGreen,
                      size: 28,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ClaimHistoryScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.history,
                      color: primaryGreen,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            
            // Rewards title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Rewards',
                    style: TextStyle(
                      color: Color(0xFF099509),
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: _InfoIconWithTooltip(),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Rewards list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Fertilizer Voucher Card
                  _RewardCard(
                    iconAsset: 'assets/images/fertilizer_icon.png',
                    title: 'Fertilizer Voucher',
                    description: 'Receive 2 sacks (50 kg each) of complete fertilizer.',
                    points: 750,
                    onRedeem: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Seedling Voucher Card
                  _RewardCard(
                    iconAsset: 'assets/images/seedling_icon.png',
                    title: 'Seedling Voucher',
                    description: 'Receive 10 bundles of ready-to-plant rice seedlings.',
                    descriptionSubtext: '(Available varieties may vary)',
                    points: 550,
                    onRedeem: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      );
                    },
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

class _RewardCard extends StatelessWidget {
  final String iconAsset;
  final String title;
  final String description;
  final String? descriptionSubtext;
  final int points;
  final VoidCallback onRedeem;

  const _RewardCard({
    required this.iconAsset,
    required this.title,
    required this.description,
    this.descriptionSubtext,
    required this.points,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    const Color cardBorder = Color(0xFFE8D78C);
    
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEF1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: cardBorder,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4AF37).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF9E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: Colors.orange[700],
              size: 32,
            ),
          ),
          
          const SizedBox(width: 12),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and points
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF005300),
                        ),
                      ),
                    ),
                    Text(
                      'Agri Points: $points',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF099509),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 6),
                
                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                
                if (descriptionSubtext != null) ...[
                  Text(
                    descriptionSubtext!,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                      height: 1.3,
                    ),
                  ),
                ],
                
                const SizedBox(height: 12),
                
                // Redeem button
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.5),
                        builder: (context) => _RedeemDialog(
                          title: title,
                          points: points,
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      side: const BorderSide(
                        color: Color(0xFF005300),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Redeem',
                      style: TextStyle(
                        color: Color(0xFF005300),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoIconWithTooltip extends StatefulWidget {
  @override
  State<_InfoIconWithTooltip> createState() => _InfoIconWithTooltipState();
}

class _InfoIconWithTooltipState extends State<_InfoIconWithTooltip> {
  bool _showTooltip = false;
  final GlobalKey _iconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const Color textGreen = Color(0xFF099509);
    
    return GestureDetector(
      key: _iconKey,
      onTap: () {
        if (_showTooltip) {
          setState(() {
            _showTooltip = false;
          });
        } else {
          setState(() {
            _showTooltip = true;
          });
          
          // Show overlay
          final RenderBox renderBox = _iconKey.currentContext!.findRenderObject() as RenderBox;
          final position = renderBox.localToGlobal(Offset.zero);
          
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (context) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _showTooltip = false;
                  });
                },
                  child: Stack(
                  children: [
                    Positioned(
                      top: position.dy + 28,
                      left: position.dx - 82.5,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: 185,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F0),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'How It Works:',
                                style: TextStyle(
                                  color: textGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                '1. Tap Redeem to get your QR code.',
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '2. Visit the nearest Department of Agriculture office.',
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                '3. Show your QR code to the staff to claim your rewards.',
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 12,
                                  height: 1.4,
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
            },
          ).then((_) {
            setState(() {
              _showTooltip = false;
            });
          });
        }
      },
      child: Icon(
        Icons.info_outline,
        color: Color(0xFF557955).withOpacity(0.66),
        size: 20,
      ),
    );
  }
}

class _RedeemDialog extends StatelessWidget {
  final String title;
  final int points;

  const _RedeemDialog({
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF005300);
    const Color lightGreen = Color(0xFF099509);
    const Color scanMeColor = Color(0xFF6B976B);
    
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 286,
        height: 357,
        decoration: BoxDecoration(
          color: const Color(0xFFE2FFB4),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: const Color(0xFF2DE62D).withOpacity(0.5),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Redeem',
              style: TextStyle(
                color: darkGreen,
                fontSize: 26.67,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Reward name
            Text(
              title,
              style: const TextStyle(
                color: lightGreen,
                fontSize: 13.33,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            
            // Points
            Text(
              '$points Agri Points',
              style: const TextStyle(
                color: lightGreen,
                fontSize: 10.67,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            
            // QR Code placeholder
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.qr_code_2,
                    size: 150,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Scan Me',
                    style: TextStyle(
                      color: scanMeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
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
