import 'package:flutter/material.dart';

class PlotDetailsPage extends StatefulWidget {
  final String title;
  final String variety;
  final String age;
  final bool healthy;

  const PlotDetailsPage({
    super.key,
    required this.title,
    required this.variety,
    required this.age,
    required this.healthy,
  });

  @override
  State<PlotDetailsPage> createState() => _PlotDetailsPageState();
}

class _PlotDetailsPageState extends State<PlotDetailsPage> {
  static const Color primaryGreen = Color(0xFF099509);
  static const Color paleYellow = Color(0xFFF6EAA7);
  static const Color taskRed = Color(0xFFDC6969);

  late String plotTitle;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay(hour: 10, minute: 0);
  DateTime currentWeekStart = DateTime.now();
  List<Map<String, dynamic>> tasks = [];
  List<String> selectedSymptoms = [];
  List<String> tempSelectedSymptoms = [];

  // Available symptoms to choose from
  final List<String> availableSymptoms = [
    'Stunted Growth',
    'Weak Stems',
    'Yellow Leaves',
    'Brown Spots',
    'Wilting',
    'Root Rot',
    'Leaf Curl',
    'Pest Infestation',
    'Fungal Growth',
    'Nutrient Deficiency',
  ];

  @override
  void initState() {
    super.initState();
    plotTitle = widget.title;
    // Initialize with sample tasks
    tasks = [
      {
        'date': DateTime(2024, 9, 3),
        'label': 'Check for ...',
        'notes': 'No notes',
      },
      {
        'date': DateTime(2024, 9, 15),
        'label': 'Check for ...',
        'notes': 'No notes',
      },
    ];
    // Initialize with sample symptoms
    selectedSymptoms = ['Stunted Growth', 'Weak Stems'];
    // Set current week start to the beginning of the week
    currentWeekStart = _getWeekStart(DateTime.now());
  }

  DateTime _getWeekStart(DateTime date) {
    // Get the start of the week (Sunday)
    return date.subtract(Duration(days: date.weekday % 7));
  }

  void _navigateWeek(bool forward) {
    setState(() {
      currentWeekStart = currentWeekStart.add(Duration(days: forward ? 7 : -7));
    });
  }

  bool _hasTaskOnDate(DateTime date) {
    return tasks.any((task) {
      final taskDate = task['date'] as DateTime;
      return taskDate.year == date.year &&
          taskDate.month == date.month &&
          taskDate.day == date.day;
    });
  }

  void _showMonthCalendar() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: currentWeekStart,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryGreen,
              onPrimary: Colors.white,
              onSurface: Colors.black,
              surface: Color(0xFFFFFFF3),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: primaryGreen),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        currentWeekStart = _getWeekStart(pickedDate);
      });
    }
  }

  void _showEditTaskSheet(
    BuildContext ctx, {
    Map<String, dynamic>? task,
    int? taskIndex,
  }) {
    final titleController = TextEditingController(text: task?['label'] ?? '');
    final notesController = TextEditingController(text: task?['notes'] ?? '');
    DateTime taskDate = task?['date'] ?? selectedDate;
    TimeOfDay taskTime = selectedTime;

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (c) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.85,
              minChildSize: 0.4,
              maxChildSize: 0.95,
              builder: (_, controller) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEFEF1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          task == null ? 'New Task' : 'Edit Task',
                          style: const TextStyle(
                            fontFamily: 'Gotham',
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF099509),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Title
                        const Text(
                          'Title',
                          style: TextStyle(
                            color: Color(0xFF099509),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: 'Title',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF77C000)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        const Text(
                          'Description',
                          style: TextStyle(
                            color: Color(0xFF099509),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: notesController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            hintText: 'Description',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF77C000)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Date row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Date',
                                    style: TextStyle(
                                      color: Color(0xFF099509),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  InkWell(
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final pickedDate = await showDatePicker(
                                        context: ctx,
                                        initialDate: taskDate,
                                        firstDate: DateTime(now.year - 2),
                                        lastDate: DateTime(now.year + 2),
                                        builder: (context, child) {
                                          return Theme(
                                            data: Theme.of(context).copyWith(
                                              colorScheme: ColorScheme.light(
                                                primary: primaryGreen,
                                                onPrimary: Colors.white,
                                                onSurface: Colors.black,
                                                surface: Color(0xFFFFFFF3),
                                              ),
                                              textButtonTheme:
                                                  TextButtonThemeData(
                                                    style: TextButton.styleFrom(
                                                      foregroundColor:
                                                          primaryGreen,
                                                    ),
                                                  ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (pickedDate != null) {
                                        setModalState(
                                          () => taskDate = pickedDate,
                                        );
                                      }
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: const Color(0xFF77C000),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"][taskDate.weekday - 1]}, '
                                            '${_monthName(taskDate.month)} ${taskDate.day}',
                                            style: const TextStyle(
                                              color: Color(0xFFE6B94C),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.edit_calendar,
                                            color: Color(0xFF099509),
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Time
                        const Text(
                          'Time',
                          style: TextStyle(
                            color: Color(0xFF099509),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () async {
                            final pickedTime = await showTimePicker(
                              context: ctx,
                              initialTime: taskTime,
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: primaryGreen,
                                      onPrimary: Colors.white,
                                      onSurface: primaryGreen,
                                      surface: Color(0xFFFDFDD0),
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      dialHandColor: primaryGreen,
                                      backgroundColor: const Color(0xFFFDFDD0),
                                      hourMinuteColor: Colors.transparent,
                                      hourMinuteTextColor:
                                          MaterialStateColor.resolveWith(
                                            (states) => const Color(0xFFE9BE35),
                                          ),
                                      dayPeriodColor:
                                          MaterialStateColor.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              MaterialState.selected,
                                            )) {
                                              return const Color(
                                                0xFF77C000,
                                              ).withOpacity(0.54);
                                            }
                                            return const Color(0xFFE8F5D0);
                                          }),
                                      dayPeriodTextColor:
                                          MaterialStateColor.resolveWith((
                                            states,
                                          ) {
                                            if (states.contains(
                                              MaterialState.selected,
                                            )) {
                                              return Colors.white;
                                            }
                                            return const Color(0xFF77C000);
                                          }),
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedTime != null) {
                              setModalState(() => taskTime = pickedTime);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF77C000),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  taskTime.format(context),
                                  style: const TextStyle(
                                    color: Color(0xFFE6B94C),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Icon(
                                  Icons.access_time,
                                  color: Color(0xFF099509),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Repeat
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Repeat',
                              style: TextStyle(
                                color: Color(0xFF099509),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            DropdownButton<String>(
                              value: 'Never',
                              items: const [
                                DropdownMenuItem(
                                  value: 'Never',
                                  child: Text('Never'),
                                ),
                                DropdownMenuItem(
                                  value: 'Daily',
                                  child: Text('Daily'),
                                ),
                                DropdownMenuItem(
                                  value: 'Weekly',
                                  child: Text('Weekly'),
                                ),
                              ],
                              onChanged: (_) {},
                              underline: const SizedBox.shrink(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Add/Save Task button
                        Center(
                          child: SizedBox(
                            width: 180,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () {
                                if (titleController.text.isNotEmpty) {
                                  setState(() {
                                    if (task == null) {
                                      // Add new task
                                      tasks.add({
                                        'date': taskDate,
                                        'label': titleController.text,
                                        'notes': notesController.text.isEmpty
                                            ? 'No notes'
                                            : notesController.text,
                                      });
                                    } else {
                                      // Edit existing task
                                      tasks[taskIndex!] = {
                                        'date': taskDate,
                                        'label': titleController.text,
                                        'notes': notesController.text.isEmpty
                                            ? 'No notes'
                                            : notesController.text,
                                      };
                                    }
                                  });
                                }
                                Navigator.of(ctx).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFD3EC86),
                                foregroundColor: primaryGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                task == null ? 'Add Task' : 'Save Task',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  String _monthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  String _getMonthName(int month) {
    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    // Calculate days until next check up (find nearest future task)
    int daysUntilCheckup = 0;
    if (tasks.isNotEmpty) {
      final futureTasks = tasks.where((t) {
        final taskDate = t['date'] as DateTime;
        return taskDate.isAfter(now);
      }).toList();
      if (futureTasks.isNotEmpty) {
        futureTasks.sort(
          (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
        );
        final nextTask = futureTasks.first['date'] as DateTime;
        daysUntilCheckup = nextTask.difference(now).inDays;
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFEFEF1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryGreen),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editable title
              Row(
                children: [
                  Text(
                    plotTitle,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      final controller = TextEditingController(text: plotTitle);
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Edit Plot Name'),
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              hintText: 'Plot name',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (controller.text.isNotEmpty) {
                                  setState(() => plotTitle = controller.text);
                                }
                                Navigator.pop(ctx);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(color: primaryGreen),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      color: primaryGreen,
                      size: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Calendar card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFA6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => _navigateWeek(false),
                          child: const Text(
                            '< Prev week',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: _showMonthCalendar,
                          child: Text(
                            _getMonthName(currentWeekStart.month),
                            style: const TextStyle(
                              color: primaryGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => _navigateWeek(true),
                          child: const Text(
                            'Next week >',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(7, (i) {
                        final date = currentWeekStart.add(Duration(days: i));
                        final isToday =
                            date.year == now.year &&
                            date.month == now.month &&
                            date.day == now.day;
                        final hasTask = _hasTaskOnDate(date);

                        return Container(
                          width: 40,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          decoration: BoxDecoration(
                            color: isToday
                                ? primaryGreen
                                : (hasTask ? taskRed : const Color(0xFFFFFFA6)),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: isToday
                                  ? primaryGreen
                                  : (hasTask ? taskRed : primaryGreen),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: (isToday || hasTask)
                                      ? Colors.white
                                      : primaryGreen,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                [
                                  'S',
                                  'M',
                                  'T',
                                  'W',
                                  'T',
                                  'F',
                                  'S',
                                ][date.weekday % 7],
                                style: TextStyle(
                                  color: (isToday || hasTask)
                                      ? Colors.white
                                      : primaryGreen,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        daysUntilCheckup > 0
                            ? '${daysUntilCheckup.toString().padLeft(2, '0')} days left until next check up'
                            : 'No upcoming check ups',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Tasks
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8FFC3).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Tasks',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF018D01),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _showEditTaskSheet(context),
                          icon: const Icon(Icons.add, color: primaryGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: tasks.asMap().entries.map((entry) {
                        final index = entry.key;
                        final t = entry.value;
                        final taskDate = t['date'] as DateTime;

                        return InkWell(
                          onTap: () => _showEditTaskSheet(
                            context,
                            task: t,
                            taskIndex: index,
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF77C000).withOpacity(0.54),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF77C000,
                                    ).withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        _monthName(taskDate.month),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF018D01),
                                        ),
                                      ),
                                      Text(
                                        '${taskDate.day}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xFF018D01),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        t['label'] ?? '',
                                        style: const TextStyle(
                                          color: Color(0xFF018D01),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        t['notes'] ?? '',
                                        style: const TextStyle(
                                          color: Color(0xFF018D01),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.edit,
                                  color: Color(0xFF018D01),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Symptoms
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFCAFBAC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Symptoms',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF018D01),
                              ),
                            ),
                            PopupMenuButton<void>(
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.black54,
                              ),
                              offset: const Offset(0, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              onOpened: () {
                                setState(() {
                                  tempSelectedSymptoms = [];
                                });
                              },
                              itemBuilder: (context) {
                                final items = availableSymptoms
                                    .where((s) => !selectedSymptoms.contains(s))
                                    .map(
                                      (symptom) => PopupMenuItem<void>(
                                        enabled: false,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (tempSelectedSymptoms.contains(
                                                symptom,
                                              )) {
                                                tempSelectedSymptoms.remove(
                                                  symptom,
                                                );
                                              } else {
                                                tempSelectedSymptoms.add(
                                                  symptom,
                                                );
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  tempSelectedSymptoms.contains(
                                                    symptom,
                                                  )
                                                  ? const Color(0xFFD3EC86)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    symptom,
                                                    style: TextStyle(
                                                      color:
                                                          tempSelectedSymptoms
                                                              .contains(symptom)
                                                          ? primaryGreen
                                                          : Colors.black87,
                                                      fontWeight:
                                                          tempSelectedSymptoms
                                                              .contains(symptom)
                                                          ? FontWeight.w600
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                if (tempSelectedSymptoms
                                                    .contains(symptom))
                                                  const Icon(
                                                    Icons.check_circle,
                                                    color: primaryGreen,
                                                    size: 20,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList();

                                // Add Apply button at the bottom
                                items.add(
                                  PopupMenuItem<void>(
                                    enabled: false,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed:
                                              tempSelectedSymptoms.isNotEmpty
                                              ? () {
                                                  setState(() {
                                                    selectedSymptoms.addAll(
                                                      tempSelectedSymptoms,
                                                    );
                                                    tempSelectedSymptoms = [];
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFFD3EC86,
                                            ),
                                            foregroundColor: primaryGreen,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Apply',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );

                                return items;
                              },
                            ),
                          ],
                        ),
                        Text(
                          widget.healthy
                              ? 'Healthy'
                              : 'Suspected Sheath Blight',
                          style: TextStyle(
                            color: widget.healthy
                                ? const Color(0xFF018D01)
                                : const Color(0xFFD21100),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Log any visible symptoms',
                      style: TextStyle(color: Color(0xFF5D5D5D), fontSize: 12),
                    ),
                    const SizedBox(height: 12),

                    // Display selected symptoms
                    if (selectedSymptoms.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: selectedSymptoms.map((symptom) {
                          return Chip(
                            label: Text(symptom),
                            deleteIcon: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                            onDeleted: () {
                              setState(() {
                                selectedSymptoms.remove(symptom);
                              });
                            },
                            backgroundColor: const Color(0xFF099509),
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }).toList(),
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
}
