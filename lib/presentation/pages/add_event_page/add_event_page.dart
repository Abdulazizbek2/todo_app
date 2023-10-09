import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/aplication/calendar_bloc/calendar_bloc.dart';
import 'package:todo_app/infrastructure/db_repository/database_repository.dart';
import 'package:todo_app/infrastructure/models/event_model.dart';
import 'package:todo_app/presentation/components/buttons/custom_buttons.dart';
import 'package:todo_app/presentation/components/custom_text_field.dart';
import 'package:todo_app/presentation/components/un_focus.dart';
import 'package:todo_app/presentation/styles/style.dart';
import 'package:todo_app/presentation/styles/theme_warpper.dart';

class AddEventPage extends StatefulWidget {
  final EventModel? event;
  const AddEventPage({super.key, required this.event});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  late FocusNode focusNode;
  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController timeController;
  late List<Color> dropDownItems;
  late GlobalKey<FormState> _formKey;
  bool isSelected = false;
  AutovalidateMode? autovalidateMode;
  bool isEdit = false;

  @override
  void initState() {
    isEdit = widget.event != null;
    focusNode = FocusNode();
    _formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.event?.name);
    descriptionController =
        TextEditingController(text: widget.event?.description);
    locationController = TextEditingController(text: widget.event?.location);
    timeController = TextEditingController(text: widget.event?.time);
    dropDownItems = [
      const Color(0xff009FEE),
      const Color(0xffEE2B00),
      const Color(0xffEE8F00),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: OnUnFocusTap(
            child: ThemeWrapper(
              builder: (context, colors, fonts, icons, controller) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: colors.backgroundColor,
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 40.h,
                            bottom: 32.h,
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: SvgPicture.asset(icons.arrowLeft),
                          ),
                        ),
                        CustomTextField(
                          autovalidateMode: autovalidateMode,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'input_required'.tr();
                            }
                            return null;
                          },
                          controller: nameController,
                          title: 'event_name'.tr(),
                          hintText: 'Event name',
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                          child: Text(
                            'event_description'.tr(),
                            style: fonts.regular14,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => focusNode.requestFocus(),
                          child: Container(
                            height: 92.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: colors.filledColor,
                              border: Border.all(color: colors.stroke),
                            ),
                            child: CustomTextField(
                              controller: descriptionController,
                              hintText: 'Description',
                              focusNode: focusNode,
                              maxLines: 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: CustomTextField(
                            autovalidateMode: autovalidateMode,
                            controller: locationController,
                            title: 'event_location'.tr(),
                            hintText: 'location',
                            suffixIcon: SvgPicture.asset(
                              icons.location,
                              colorFilter: ColorFilter.mode(
                                colors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
                          child: Text(
                            'priority_color'.tr(),
                            style: fonts.regular14,
                          ),
                        ),
                        Container(
                          height: 32.h,
                          width: 72.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colors.filledColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: DropdownButton<Color>(
                            underline: const SizedBox(),
                            value: isSelected
                                ? state.dropDownValue
                                : widget.event?.color ?? state.dropDownValue,
                            borderRadius: BorderRadius.circular(8.r),
                            icon: Icon(Icons.keyboard_arrow_down_outlined,
                                size: 30, color: colors.primary),
                            items: List.generate(
                              dropDownItems.length,
                              (index) => DropdownMenuItem(
                                value: dropDownItems[index],
                                alignment: Alignment.center,
                                child: Container(
                                  width: 23.w,
                                  height: 20.h,
                                  margin: EdgeInsets.only(right: 8.w),
                                  color: dropDownItems[index],
                                ),
                              ),
                            ),
                            onChanged: (v) {
                              isSelected = true;
                              context.read<CalendarBloc>().add(
                                    CalendarEvent.changeDropdown(
                                      dropDownValue:
                                          v ?? const Color(0x00000000),
                                    ),
                                  );
                            },
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () => getTime(),
                          child: CustomTextField(
                            validator: (value) {
                              if (value!.trim().isEmpty) {
                                return 'input_required'.tr();
                              }
                              return null;
                            },
                            autovalidateMode: autovalidateMode,
                            controller: timeController,
                            enabled: false,
                            title: 'event_time'.tr(),
                            hintText:
                                '${DateTime.now().hour}:${DateTime.now().minute.toString().length == 1 ? 0 : ''}${DateTime.now().minute}',
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                  bottomNavigationBar: Padding(
                    padding:
                        EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                    child: CustomButton(
                      textStyle: Style.regular16(
                        size: 16.sp,
                        fontWeight1: FontWeight.w400,
                      ),
                      verticalPadding: 12.h,
                      title: isEdit ? "Save".tr() : 'Add'.tr(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EventModel event = EventModel(
                            id: widget.event?.id ?? Random().nextInt(100000),
                            time: timeController.text == ''
                                ? '${DateTime.now().hour}:${DateTime.now().minute.toString().length == 1 ? 0 : ''}${DateTime.now().minute}'
                                : timeController.text,
                            name: nameController.text,
                            location: locationController.text,
                            description: descriptionController.text,
                            color: state.dropDownValue,
                            date:
                                "${state.selectedDay?.year}-${state.selectedDay?.month}-${state.selectedDay?.day}",
                          );

                          if (!isEdit) {
                            await DBRepozitory.addEvent(event).then(
                              (value) {
                                fetchData();
                              },
                            );
                          } else {
                            await DBRepozitory.updateEvent(
                              event,
                            ).then((value) {
                              fetchData();
                            });
                          }
                        } else {
                          autovalidateMode = AutovalidateMode.always;
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    descriptionController.dispose();
    locationController.dispose();
    nameController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void fetchData() {
    context.read<CalendarBloc>()
      ..add(const CalendarEvent.getEventInSelectedDay())
      ..add(const CalendarEvent.getAllEvents());
    Navigator.pop(context);
    EasyLoading.showSuccess('success'.tr());
  }

  void getTime() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    await showTimePicker(
      context: context,
      helpText: "start_time".tr(),
      initialTime: TimeOfDay.now(),
      confirmText: "next".tr(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true,
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? value) async {
      if (value != null) {
        await showTimePicker(
          context: context,
          helpText: "end_time".tr(),
          initialTime: value,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                alwaysUse24HourFormat: true,
              ),
              child: child!,
            );
          },
        ).then((value2) {
          if (value2 != null) {
            timeController.text =
                "${value.hour}:${value.minute.toString().length == 1 ? 0 : ''}${value.minute} - ${value2.hour}:${value2.minute.toString().length == 1 ? 0 : ''}${value2.minute}";
          }
        });
      }
    });
  }
}
