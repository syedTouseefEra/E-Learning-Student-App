

import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:e_learning/constant/palette.dart';
import 'package:e_learning/custom_widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CalendarView> {
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDate = DateTime.now();
  bool isDayView = false;
  int requestType = 2;
  bool isWeekView = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightBlueBackground, width: 1.5.w),
        borderRadius: BorderRadius.circular(7.h),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.sp, 8.sp, 15.sp, 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text:
                      "${_focusedDate.day} ${DateFormat('MMMM').format(_focusedDate)} ${_focusedDate.year}",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                  color: AppColors.themeColor,
                  textAlign: TextAlign.center,
                ),

                CustomSlidingSegmentedControl<int>(
                    initialValue: requestType,
                    height: 25.h,padding: 6.5.w,
                    children: {
                      1: CustomText(
                        text: " Day    ",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color:
                        requestType==1 ? Colors.white : AppColors.themeColor,
                        textAlign: TextAlign.center,
                      ),
                      2: CustomText(
                        text: " Week ",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                        color: requestType==2 ? Colors.white : AppColors.themeColor,
                        textAlign: TextAlign.center,
                      ),
                    },
                    innerPadding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.themeColor),
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    thumbDecoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInToLinear,
                    onValueChanged:  (index) {
                      setState(() {
                        requestType = index;
                        if (requestType == 1) {
                          _calendarFormat = CalendarFormat.month;
                        } else {
                          isDayView = false;
                          _calendarFormat = CalendarFormat.week;
                        }
                      });
                    },
                ),

              ],
            ),
          ),
          Divider(color: AppColors.lightBlueBackground,thickness: 1.5.sp,),
          TableCalendar(
            headerVisible: false,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            focusedDay: _focusedDate,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              dowBuilder: (context, day) {
                final text = DateFormat.E().format(day);
                return Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        color: Colors.black),
                  ),
                );
              },
              defaultBuilder: (context, date, focusedDay) {
                return Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(
                        color: Colors.black),
                  ),
                );
              },
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.lightBlueBackground,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.lightBlueBackground,
                shape: BoxShape.circle,
              ),
              weekendTextStyle:
                  TextStyle(color: Colors.black),
              holidayTextStyle:
                  TextStyle(color: Colors.black),
              todayTextStyle:
                  TextStyle(color: Colors.black),
              selectedTextStyle: TextStyle(
                  color: Colors.black),
            ),
          ),
          SizedBox(
            height: 5.h,
          )
        ],
      ),
    );
  }
}
