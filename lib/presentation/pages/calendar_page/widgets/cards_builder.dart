import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/presentation/pages/calendar_page/widgets/event_cart.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class CardsBuilder extends StatelessWidget {
  final CalendarState state;
  const CardsBuilder({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return ThemeWrapper(
      builder: (context, colors, fonts, icons, controller) {
        List<EventModel>? items = state.eventModelList ?? [];
        return items.isNotEmpty
            ? Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: items.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return EventCart(
                        item: items[index],
                      );
                    },
                  ),
                ),
              )
            : Center(heightFactor: 10, child: Text('no_data'.tr()));
      },
    );
  }
}
