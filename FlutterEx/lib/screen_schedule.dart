import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data.dart';

class ScreenSchedule extends StatefulWidget {
  final Schedule schedule;

  ScreenSchedule({super.key, required this.schedule});

  @override
  State<ScreenSchedule> createState() => _ScreenScheduleState();
}

class _ScreenScheduleState extends State<ScreenSchedule> {
  late DateTime _fromDate;
  late DateTime _toDate;
  late TimeOfDay _fromTime;
  late TimeOfDay _toTime;
  late List<bool> _weekdays;

  final DateFormat _dateFormatter = DateFormat.yMd();

  @override
  void initState() {
    super.initState();
    _fromDate = widget.schedule.fromDate;
    _toDate = widget.schedule.toDate;
    _fromTime = widget.schedule.fromTime;
    _toTime = widget.schedule.toTime;
    _weekdays = List.generate(7, (index) => widget.schedule.weekdays.contains(index + 1));
  }

  void _showAlert(String title, String message) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap the button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(message)],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule employees"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selección de fecha "From"
            Row(
              children: [
                const Text("From", style: TextStyle(fontSize: 16.0)),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_dateFormatter.format(_fromDate)),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _fromDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2025),
                    );
                    if (pickedDate != null && pickedDate != _fromDate) {
                      setState(() {
                        _fromDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            // Selección de fecha "To"
            Row(
              children: [
                const Text("To", style: TextStyle(fontSize: 16.0)),
                const SizedBox(width: 35.0),
                TextButton.icon(
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_dateFormatter.format(_toDate)),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _toDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null && pickedDate != _toDate) {
                      setState(() {
                        _toDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            // Selector de días de la semana usando ChoiceChip
            const Text("Weekdays", style: TextStyle(fontSize: 16.0)),
            Wrap(
              spacing: 8.0,
              children: List.generate(7, (index) {
                final dayLabels = ["Mo", "Tu", "We", "Tu", "Fr", "Sa", "Su"];
                return ChoiceChip(
                  label: Text(dayLabels[index]),
                  selected: _weekdays[index],
                  onSelected: (bool selected) {
                    setState(() {
                      _weekdays[index] = selected;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 24.0),
            // Selección de hora "From"
            Row(
              children: [
                const Text("From", style: TextStyle(fontSize: 16.0)),
                const SizedBox(width: 16.0),
                TextButton.icon(
                  icon: const Icon(Icons.access_time),
                  label: Text(_fromTime.format(context)),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _fromTime,
                    );
                    if (pickedTime != null && pickedTime != _fromTime) {
                      setState(() {
                        _fromTime = pickedTime;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            // Selección de hora "To"
            Row(
              children: [
                const Text("To", style: TextStyle(fontSize: 16.0)),
                const SizedBox(width: 35.0),
                TextButton.icon(
                  icon: const Icon(Icons.access_time),
                  label: Text(_toTime.format(context)),
                  onPressed: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: _toTime,
                    );
                    if (pickedTime != null && pickedTime != _toTime) {
                      setState(() {
                        _toTime = pickedTime;
                      });
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 36.0),
            // Botón de guardar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_fromDate.isAfter(_toDate)) {
                    _showAlert("Rang Dates", "The From date is after the To date. Please, select a new date range.");
                  } else {
                    // Actualiza el objeto Schedule
                    widget.schedule.weekdays = List.generate(
                      7,
                      (index) => _weekdays[index] ? index + 1 : 0,
                    ).where((day) => day != 0).toList();
                    widget.schedule.fromDate = _fromDate;
                    widget.schedule.toDate = _toDate;
                    widget.schedule.fromTime = _fromTime;
                    widget.schedule.toTime = _toTime;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Saved')),
                    );
                  }
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
