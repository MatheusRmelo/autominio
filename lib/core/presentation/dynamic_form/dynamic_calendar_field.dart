import 'package:flutter/material.dart';

import '../calendar_widget.dart';

class DynamicCalendarField extends StatefulWidget {
  const DynamicCalendarField(
      {super.key,
      required this.label,
      required this.activeDate,
      required this.onChanged});
  final String label;
  final DateTime activeDate;
  final ValueChanged<DateTime?> onChanged;
  @override
  State<DynamicCalendarField> createState() => _DynamicCalendarFieldState();
}

class _DynamicCalendarFieldState extends State<DynamicCalendarField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 280,
          child: CalendarWidget(
            activeDate: DateTime(widget.activeDate.year,
                widget.activeDate.month, widget.activeDate.day),
            onChanged: (DateTime? date) {
              if (date?.day != null) {
                widget.onChanged(date!);
              }
            },
          ),
        ),
      ],
    );
  }
}
