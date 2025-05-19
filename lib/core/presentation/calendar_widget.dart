import 'package:flutter/material.dart';

import 'custom_text.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget(
      {super.key, required this.activeDate, required this.onChanged});
  final DateTime activeDate;
  final ValueChanged<DateTime?> onChanged;
  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final List<String> weekDays = [
    'Domingo',
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
  ];
  List<DayModel> _days = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    List<DayModel> days = [];
    int daysInMonth = DateUtils.getDaysInMonth(
        widget.activeDate.year, widget.activeDate.month);
    DateTime firstDay =
        DateTime(widget.activeDate.year, widget.activeDate.month, 1);
    if (firstDay.weekday != 7) {
      int daysPrevMonth = widget.activeDate.month > 1
          ? DateUtils.getDaysInMonth(
              widget.activeDate.year, widget.activeDate.month - 1)
          : DateUtils.getDaysInMonth(widget.activeDate.year - 1, 12);
      for (int i = firstDay.weekday - 1; i >= 0; i--) {
        days.add(DayModel(day: (daysPrevMonth - i), isDisabled: true));
      }
    }

    int currentSize = days.length;
    for (int i = 1; i <= (42 - currentSize); i++) {
      if (i <= daysInMonth) {
        days.add(DayModel(
          day: i,
        ));
      } else {
        days.add(DayModel(day: (i - daysInMonth), isDisabled: true));
      }
    }
    setState(() {
      _days = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: List.generate(
                7,
                (index) => Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: CustomText(weekDays[index].substring(0, 3),
                            color: Colors.white),
                      ),
                    )),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
              child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7, childAspectRatio: 1.5),
            itemBuilder: (context, index) => InkWell(
              onTap: _days[index].isDisabled
                  ? null
                  : () {
                      widget.onChanged(DateTime(widget.activeDate.year,
                          widget.activeDate.month, _days[index].day));
                    },
              child: Container(
                decoration: BoxDecoration(
                    border: _days[index].day == widget.activeDate.day &&
                            !_days[index].isDisabled
                        ? Border.all(color: Colors.white, width: 1)
                        : null,
                    color: _days[index].day == widget.activeDate.day &&
                            !_days[index].isDisabled
                        ? Theme.of(context).primaryColor
                        : _days[index].isDisabled
                            ? Colors.grey.withOpacity(0.5)
                            : Colors.transparent),
                alignment: Alignment.center,
                child: CustomText(
                  (_days[index].day).toString(),
                  color: _days[index].isDisabled
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white,
                ),
              ),
            ),
            itemCount: _days.length,
          ))
        ],
      ),
    );
  }
}

class DayModel {
  int day;
  bool isDisabled;
  DayModel({required this.day, this.isDisabled = false});
}
