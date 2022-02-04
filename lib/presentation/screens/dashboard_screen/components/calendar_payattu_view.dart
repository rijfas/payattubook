import 'package:flutter/material.dart';
import 'package:payattubook/core/utils/utils.dart';
import 'package:payattubook/data/manage_payattu/models/user_payattu.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../logic/manage_payattu/cubit/manage_payattu_cubit.dart';
import '../components/bottom_payattu_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/rounded_elevated_button.dart';

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
                  color: Theme.of(context).primaryColor),
            ),
            onDaySelected: _onDaySelected,
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
          ValueListenableBuilder<List<Map<int, UserPayattu>>>(
            valueListenable: _selectedPayatts,
            builder: (context, value, _) {
              if (value.length == 0) {
                return Center(
                  child: Text('No Payatt'),
                );
              }
              return ListView.builder(
                itemCount: value.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: ListTile(
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
                                    context
                                        .read<ManagePayattuCubit>()
                                        .removePayattu(
                                            index: value[index].keys.first);
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          value[index].values.first.payattu.coverImageUrl),
                    ),
                    title: Text(
                      value[index].values.first.payattu.host,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      value[index].values.first.payattu.date.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    trailing: Text(value[index].values.first.amount.toString()),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
