import 'package:flutter/material.dart';
import 'add_plot.dart';
import 'plot_details.dart';

class PlotManagerPage extends StatelessWidget {
  const PlotManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF099509);
    const Color paleYellow = Color(0xFFF6EAA7);

    Widget _plotCard({
      required String title,
      required String variety,
      required String age,
      required bool healthy,
    }) {
      return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PlotDetailsPage(
                title: title,
                variety: variety,
                age: age,
                healthy: healthy,
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: paleYellow, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 8,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                SizedBox(
                  width: 96,
                  height: 96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/plot_pic.png',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.green[50],
                        child: const Icon(
                          Icons.agriculture,
                          color: primaryGreen,
                          size: 44,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: primaryGreen,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: healthy ? Colors.green : Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                healthy ? 'Healthy' : 'Suspected Sheath Blight',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        variety,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        age,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEF1),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // menu icon
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.menu, color: Colors.green),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Plots',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF099509),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: [
                        _plotCard(
                          title: 'Plot A',
                          variety: 'Jasmine Rice',
                          age: '20 weeks old',
                          healthy: true,
                        ),
                        _plotCard(
                          title: 'Plot B',
                          variety: 'Jasmine Rice',
                          age: '20 weeks old',
                          healthy: false,
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // FAB style add
            Positioned(
              right: 20,
              bottom: 30,
              child: FloatingActionButton(
                backgroundColor: primaryGreen,
                onPressed: () async {
                  // show overlay at ~80% of screen height
                  final result = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => SizedBox(
                      height: MediaQuery.of(ctx).size.height * 0.8,
                      child: const AddPlotOverlay(),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                  );

                  if (result != null) {
                    // optional: handle returned plot data
                    // debug print for now
                    // ignore: avoid_print
                    print('New plot added: $result');
                  }
                },
                child: const Icon(Icons.add, size: 28, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
