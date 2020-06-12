import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalenderResponseEvents {


//  CalenderResponseEvents(BuildContext buildContext,DateTime dateTime
//      ){
//    context = buildContext;
//    selectedDate = dateTime;
//  }


  static Future<DateTime> selectDateWithDatePicker(BuildContext context, DateTime selectedDate) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate == null ? DateTime.now() : selectedDate,
      firstDate: DateTime(DateTime
          .now()
          .year - 30),
      lastDate: DateTime(DateTime
          .now()
          .year + 50),);
    if (picked != null)
      selectedDate = picked;

    return selectedDate;
  }

  static Future<TimeOfDay> getTimeWithTimePicker(TimeOfDay time,BuildContext context) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: time == null ? TimeOfDay.now() : time,
    );
    if (picked != null && picked != time)
      time = picked;

    return time;
  }

}