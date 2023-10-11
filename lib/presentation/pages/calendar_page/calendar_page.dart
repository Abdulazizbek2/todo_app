import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/add_event_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/appbar_widget.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/cal_w.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/cards_builder.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late DateTime selectedMonth;

  // late DateTime selectedDate;

  @override
  void initState() {
    // selectedMonth = DateTime.now().monthStart;
    // selectedDate = DateTime.now();
    //  LocalDatabase.getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return ThemeWrapper(
          builder: (context, colors, fonts, icons, controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: colors.backgroundColor,
              body: state.eventMap != null &&
                      state.selectedMonth != null &&
                      state.selectedDay != null &&
                      state.eventModelList != null
                  ? SafeArea(
                      child: Column(
                        children: [
                          AppbarWidget(
                            state: state,
                          ),
                          Header(
                            state: state,
                          ),
                          Body(
                              state: state,
                              selectDate: (DateTime value) => context
                                  .read<CalendarBloc>()
                                  .add(CalendarEvent.selectDay(
                                      selectedDay: value))),
                          SizedBox(height: 28.h),
                          const AddEventWidget(),
                          SizedBox(height: 20.h),
                          CardsBuilder(state: state),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
            );
          },
        );
      },
    );
  }
}
