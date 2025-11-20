import 'package:flutter/material.dart';

class PlotDetailsPage extends StatelessWidget {
  final String title;
  final String variety;
  final String age;
  final bool healthy;

  const PlotDetailsPage({super.key, required this.title, required this.variety, required this.age, required this.healthy});

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF099509);
    const Color paleYellow = Color(0xFFF6EAA7);

    // sample tasks and symptoms (in a real app these would come from a model)
    final tasks = [
      {'day': '3', 'label': 'Check for ...', 'notes': 'No notes', 'month': 'Sep'},
      {'day': '15', 'label': 'Check for ...', 'notes': 'No notes', 'month': 'Sep'},
    ];

    final symptoms = ['Stunted Growth', 'Weak Stems'];

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEF1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF099509)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: primaryGreen)),
              const SizedBox(height: 12),

              // calendar card (pale yellow)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: paleYellow, borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Prev week', style: TextStyle(color: Colors.black54)),
                        Text('August', style: TextStyle(color: primaryGreen, fontSize: 20, fontWeight: FontWeight.w800)),
                        const Text('Next week', style: TextStyle(color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // days row simplified
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (i) {
                        final isToday = i == 0;
                        return Container(
                          width: 40,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(color: isToday ? primaryGreen : Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: primaryGreen)),
                          child: Column(
                            children: [
                              Text('${i == 0 ? '31' : i}', style: TextStyle(color: isToday ? Colors.white : primaryGreen, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(['S','M','T','W','T','F','S'][i], style: TextStyle(color: isToday ? Colors.white : primaryGreen, fontSize: 12)),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Align(alignment: Alignment.centerLeft, child: Text('03 days left until next check up', style: TextStyle(color: Colors.black87))),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Tasks card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: primaryGreen)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: tasks.map((t) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.green[100], borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(color: Colors.green[200], borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                children: [
                                  Text(t['month'] ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                                  Text(t['day'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(t['label'] ?? ''), const SizedBox(height: 4), Text(t['notes'] ?? '', style: const TextStyle(color: Colors.black54, fontSize: 12))])),
                          ],
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // Symptoms
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Symptoms', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                        Text(healthy ? 'Healthy' : 'Suspected Sheath Blight', style: TextStyle(color: healthy ? Colors.green : Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(spacing: 8, children: symptoms.map((s) => Chip(label: Text(s))).toList()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
