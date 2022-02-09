import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../../core/constants/assets.dart';
import '../../../../../../core/utils/utils.dart';
import '../../../../../../data/manage_payattu/models/user_payattu.dart';
import '../../../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../../../../../components/confirm_popup.dart';
import '../../../../../components/default_shaded_container.dart';
import '../../../../../components/rounded_elevated_button.dart';
import '../../../components/bottom_payattu_card.dart';
import '../../../components/payattu_tile.dart';

class CalendarPayattuView extends StatefulWidget {
  const CalendarPayattuView({
    Key? key,
    required this.payattuList,
  }) : super(key: key);
  final List<UserPayattu> payattuList;
  @override
  _CalendarPayattuViewState createState() => _CalendarPayattuViewState();
}

class _CalendarPayattuViewState extends State<CalendarPayattuView> {
  late final ValueNotifier<List<Map<int, UserPayattu>>> _selectedPayatts;
  late List<UserPayattu> _availablePayatts;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<Map<int, UserPayattu>> _getPayattsForDay(DateTime day) {
    List<Map<int, UserPayattu>> currentPayatts = [];
    for (int i = 0; i < _availablePayatts.length; i++) {
      if (Utils.isSameDate(_availablePayatts[i].payattu.date, day)) {
        currentPayatts.add({i: _availablePayatts[i]});
      }
    }
    return currentPayatts;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedPayatts.value = _getPayattsForDay(selectedDay);
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _availablePayatts = widget.payattuList;
    _selectedPayatts = ValueNotifier(_getPayattsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedPayatts.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocListener<ManagePayattuCubit, ManagePayattuState>(
      listener: (context, state) {
        if (state is ManagePayattuLoaded) {
          setState(() {
            _availablePayatts = state.payattuList;
            _selectedPayatts.value = _getPayattsForDay(_selectedDay!);
          });
        }
      },
      child: Column(
        children: [
          TableCalendar<Map<int, UserPayattu>>(
            firstDay: DateTime(2022),
            lastDay: DateTime(2050),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getPayattsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayDecoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              todayTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              holidayDecoration: const BoxDecoration(
                border: Border.fromBorderSide(BorderSide.none),
              ),
              holidayTextStyle: TextStyle(color: Colors.red[300]),
            ),
            onDaySelected: _onDaySelected,
            holidayPredicate: (day) => day.weekday == 7,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Map<int, UserPayattu>>>(
              valueListenable: _selectedPayatts,
              builder: (context, value, _) {
                if (value.isEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8.0),
                      SvgPicture.asset(Assets.defaulEmptyImage,
                          width: size.width * 0.3),
                      const SizedBox(height: 8.0),
                      Text(
                          'No payattu on ${DateFormat("EEE, dd/M/y").format(_selectedDay!)}'),
                    ],
                  );
                }
                return ListView.builder(
                  itemCount: value.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) => DefaultShadedContainer(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: PayattuTile(
                      payattu: value[index].values.first.payattu,
                      onTap: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            constraints: BoxConstraints(
                              minWidth: size.width,
                              maxHeight: size.height,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                            ),
                            context: context,
                            builder: (_) => BottomPayattuCard(
                                  payattu: value[index].values.first.payattu,
                                  bottomButton: RoundedElevatedButton(
                                    color: Colors.red[300],
                                    child: const Text(
                                      'Remove from payattu list',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      showDialog<bool>(
                                        context: context,
                                        builder: (_) => const ConfirmPopup(
                                            title: 'Confirm remove?',
                                            message:
                                                'Removed payatts cannot be recovered!'),
                                      ).then((canRemove) {
                                        if (canRemove!) {
                                          context
                                              .read<ManagePayattuCubit>()
                                              .removePayattu(
                                                  index:
                                                      value[index].keys.first);
                                          Navigator.of(context).pop();
                                          Utils.showSnackBar(
                                              context: context,
                                              message:
                                                  'Payattu is removed from current payattlist');
                                        }
                                      });
                                    },
                                  ),
                                ));
                      },
                      trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            '₹ ${value[index].values.first.amount.toString()}',
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
