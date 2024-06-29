import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({super.key, required this.onChanged});

  final Function(DateTime) onChanged;


  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    widget.onChanged(args.value);
  }

  @override
  Widget build(BuildContext context) {
    return SfDateRangePicker(
      onSelectionChanged: _onSelectionChanged,
      selectionMode: DateRangePickerSelectionMode.single,
      initialSelectedDate: DateTime.now(),
      showTodayButton: true,
      maxDate: DateTime.now(),
    );
  }
}
