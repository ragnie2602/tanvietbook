import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/constants.dart';
import '../../data/resources/colors.dart';
import '../../data/resources/themes.dart';
import '../utils/utils.dart';
import 'primary_switch.dart';

class SecondaryTextField extends StatefulWidget {
  const SecondaryTextField({
    Key? key,
    this.prefixIcon,
    this.labelIcon,
    this.suffixIcon,
    required this.controller,
    this.hintText,
    this.validator,
    this.formKey,
    this.readOnly = false,
    this.keyboardType,
    this.inputType,
    this.data,
    this.context,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.done,
    this.onTap,
    this.onSubmitted,
    this.isDense = false,
    this.fillColor = Colors.white,
    this.maxLength,
    this.minLines = 1,
    this.maxLines = 20,
    this.counterText = '',
    this.obscureText = false,
    this.label,
    this.errorText,
    this.isRequired = false,
    this.isShowSwitch = false,
    this.isSwitchChecked = true,
    this.onSwitchChanged,
    this.labelStyle,
    this.onChanged,
    this.onDropdownValueChanged,
    this.disable = false,
    this.borderRadius,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  }) : super(key: key);

  // final String? label;
  final String? hintText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final dynamic labelIcon;
  final EdgeInsets? contentPadding;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool disable;
  final TextInputType? keyboardType;
  final AppInputType? inputType;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final List<String>? data;
  final BuildContext? context;
  final Function()? onTap;
  final Function(String value)? onSubmitted;
  final bool isDense;
  final bool obscureText;
  final Color? fillColor;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final String? counterText;
  final String? label;
  final String? errorText;
  final TextStyle? labelStyle;
  final bool isRequired;
  final Function(String? value)? onChanged;
  final Function(String? value, int index)? onDropdownValueChanged;
  final BorderRadius? borderRadius;

  ///  define switch should be shown or not
  final bool isShowSwitch;

  ///  initializes the switch state. This required [isShowSwitch] = true
  final bool isSwitchChecked;

  ///  callback the value of switch changes. This required [isShowSwitch] = true
  final Function(bool value)? onSwitchChanged;
  final GlobalKey<FormState>? formKey;

  @override
  State<SecondaryTextField> createState() => _SecondaryTextFieldState();
}

class _SecondaryTextFieldState extends State<SecondaryTextField> {
  final GlobalKey<FormState>? formKey2 = GlobalKey();
  String dropDownText = "";
  late bool isSwitchChecked;

  @override
  void initState() {
    if (widget.inputType == AppInputType.dropDown) {
      dropDownText = widget.data?[0].toString() ?? '';
    }
    if (widget.isShowSwitch) isSwitchChecked = widget.isSwitchChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.label != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.labelIcon != null
                          ? widget.labelIcon is String
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: SvgPicture.asset(
                                    widget.labelIcon,
                                    height: 20,
                                    width: 20,
                                  ),
                                )
                              : widget.labelIcon
                          : const SizedBox(),
                      widget.isRequired
                          ? const Text(
                              '* ',
                              style: AppTextTheme.textPrimaryRed,
                            )
                          : const SizedBox(),
                      Text(
                        widget.label!,
                        style: widget.labelStyle ?? AppTextTheme.bodyStrong,
                      ),
                    ],
                  ),
                  widget.isShowSwitch
                      ? PrimarySwitch(
                          initialValue: isSwitchChecked,
                          onToggle: (value) => widget.onSwitchChanged?.call(value),
                        )
                      : const SizedBox(),
                ],
              )
            : const SizedBox(),
        const SizedBox(
          height: 8,
        ),
        (widget.inputType == null)
            ? Form(
                key: widget.formKey,
                child: TextFormField(
                  onTap: widget.onTap,
                  readOnly: widget.readOnly,
                  style: widget.disable
                      ? AppTextTheme.bodyRegular.copyWith(color: AppColor.gray04)
                      : AppTextTheme.bodyRegular,
                  controller: widget.controller,
                  validator: widget.validator,
                  obscureText: widget.obscureText,
                  onChanged: (value) {
                    widget.formKey?.currentState!.validate();
                    widget.onChanged?.call(value);
                  },
                  onFieldSubmitted: widget.onSubmitted,
                  maxLength: widget.maxLength,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  textCapitalization: widget.textCapitalization,
                  textInputAction: widget.textInputAction,
                  keyboardType: widget.keyboardType,
                  textAlignVertical:
                      (widget.suffixIcon == null && widget.prefixIcon == null) ? null : TextAlignVertical.center,
                  decoration: InputDecoration(
                    counterText: widget.counterText,
                    isDense: widget.isDense,
                    contentPadding: widget.contentPadding,
                    hintText: widget.hintText,
                    hintStyle: AppTextTheme.textPrimaryGray05,
                    labelStyle: AppTextTheme.textPrimary,
                    errorMaxLines: 2,
                    errorText: widget.errorText,
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColor.neutral5),
                      borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColor.neutral5),
                      borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
                    ),
                    filled: true,
                    fillColor: widget.disable ? AppColor.gray : widget.fillColor,
                    alignLabelWithHint: true,
                    prefixIcon: widget.prefixIcon == null
                        ? null
                        : (widget.prefixIcon is String)
                            ? SvgPicture.asset(
                                widget.prefixIcon ?? '',
                                height: 20,
                                width: 16,
                                fit: BoxFit.scaleDown,
                              )
                            : widget.prefixIcon,
                    suffixIcon: widget.suffixIcon == null
                        ? null
                        : (widget.suffixIcon is String)
                            ? SvgPicture.asset(
                                widget.suffixIcon ?? '',
                                height: 20,
                                width: 16,
                                fit: BoxFit.scaleDown,
                              )
                            : widget.suffixIcon,
                  ),
                ),
              )
            : (widget.inputType == AppInputType.dropDown)
                ? DropdownButtonFormField2(
                    // buttonHighlightColor: AppColor.btPrimary,
                    // buttonSplashColor: AppColor.primaryColor,
                    // dropdownDecoration: BoxDecoration(
                    //   color: AppColor.white,
                    //   borderRadius: BorderRadius.circular(8),
                    // ),
                    // offset: const Offset(-8, -8),
                    value: widget.controller.text.isEmpty ? null : widget.controller.text,
                    items: widget.data?.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value, style: AppTextTheme.textPrimary),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        dropDownText = value.toString();
                        widget.controller.text = value.toString();
                        widget.onDropdownValueChanged?.call(dropDownText, widget.data!.indexOf(value!));
                        widget.onChanged;
                      });
                    },
                    isExpanded: true,
                    dropdownStyleData: DropdownStyleData(
                        width: 220,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(4),
                        )),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: widget.contentPadding,
                      hintText: widget.hintText,
                      hintStyle: AppTextTheme.textPrimaryGray05,
                      labelStyle: widget.labelStyle ?? AppTextTheme.textPrimary,
                      errorMaxLines: 2,
                      border: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                      filled: true,
                      fillColor: widget.fillColor,
                    ),
                  )
                // DropdownButton<String>(
                //             items: widget.data
                //                 ?.map<DropdownMenuItem<String>>((String value) {
                //               return DropdownMenuItem(
                //                 value: value,
                //                 child: Text(value),
                //               );
                //             }).toList(),
                //             onChanged: (value) => setState(() {
                //               dropDownText = value.toString();
                //               widget.controller.text = value.toString();
                //             }),
                //             dropdownColor: AppColor.white,
                //             value: dropDownText,
                //           )

                // type date picker
                : (widget.inputType == AppInputType.datePicker)
                    ? Form(
                        key: widget.formKey,
                        child: TextFormField(
                          onTap: widget.readOnly
                              ? () {}
                              : () async {
                                  // final selectedDate =
                                  //     await Utils.getDatePicker(widget.context!);
                                  final DateTime? selectedDate = await showDatePicker(
                                      context: widget.context!,
                                      locale: const Locale("vi"),
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100));
                                  if (selectedDate != null) {
                                    setState(() {
                                      widget.controller.text = Utils.formatDate(selectedDate.toString());
                                    });
                                  }
                                },
                          validator: widget.validator,
                          readOnly: widget.readOnly,
                          style: AppTextTheme.textPrimary,
                          controller: widget.controller,
                          keyboardType: widget.keyboardType,
                          decoration: InputDecoration(
                            isDense: widget.isDense,
                            contentPadding: widget.contentPadding,
                            hintText: widget.hintText,
                            labelStyle: AppTextTheme.textPrimary,
                            filled: true,
                            fillColor: AppColor.white,
                            border: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                            errorMaxLines: 2,
                            prefixIcon: widget.prefixIcon == null
                                ? null
                                : (widget.prefixIcon is String)
                                    ? SvgPicture.asset(
                                        widget.prefixIcon ?? '',
                                        height: 20,
                                        width: 16,
                                        fit: BoxFit.scaleDown,
                                      )
                                    : widget.prefixIcon,
                            suffixIcon: widget.suffixIcon != null
                                ? widget.suffixIcon is String
                                    ? SvgPicture.asset(widget.suffixIcon!)
                                    : Icon(
                                        widget.suffixIcon,
                                        color: AppColor.black.withOpacity(0.25),
                                      )
                                : null,
                          ),
                        ),
                      )
                    : widget.inputType == AppInputType.timePicker
                        ? Form(
                            key: widget.formKey,
                            child: TextFormField(
                              onTap: widget.readOnly
                                  ? () {}
                                  : () async {
                                      final TimeOfDay? selectedTime =
                                          await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                      if (selectedTime != null) {
                                        setState(() {
                                          widget.controller.text =
                                              Utils.toTime('${selectedTime.hour}:${selectedTime.minute}');
                                        });
                                      }
                                    },
                              validator: widget.validator,
                              readOnly: widget.readOnly,
                              style: AppTextTheme.textPrimary,
                              controller: widget.controller,
                              keyboardType: widget.keyboardType,
                              decoration: InputDecoration(
                                isDense: widget.isDense,
                                contentPadding: widget.contentPadding,
                                hintText: widget.hintText,
                                labelStyle: AppTextTheme.textPrimary,
                                filled: true,
                                fillColor: AppColor.white,
                                border: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                                enabledBorder:
                                    const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                                errorMaxLines: 2,
                                prefixIcon: widget.prefixIcon == null
                                    ? null
                                    : (widget.prefixIcon is String)
                                        ? SvgPicture.asset(
                                            widget.prefixIcon ?? '',
                                            height: 20,
                                            width: 16,
                                            fit: BoxFit.scaleDown,
                                          )
                                        : widget.prefixIcon,
                                suffixIcon: widget.suffixIcon != null
                                    ? widget.suffixIcon is String
                                        ? SvgPicture.asset(widget.suffixIcon!)
                                        : Icon(
                                            widget.suffixIcon,
                                            color: AppColor.black.withOpacity(0.25),
                                          )
                                    : null,
                              ),
                            ),
                          )
                        : (widget.inputType == AppInputType.location)
                            ? Form(
                                key: widget.formKey,
                                child: TextFormField(
                                  onTap: () async {},
                                  validator: widget.validator,
                                  readOnly: true,
                                  style: AppTextTheme.textPrimary,
                                  controller: widget.controller,
                                  keyboardType: widget.keyboardType,
                                  decoration: InputDecoration(
                                    isDense: widget.isDense,
                                    contentPadding: widget.contentPadding,
                                    hintText: widget.hintText,
                                    labelStyle: AppTextTheme.textPrimary,
                                    filled: true,
                                    fillColor: AppColor.white,
                                    border: const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                                    enabledBorder:
                                        const OutlineInputBorder(borderSide: BorderSide(color: AppColor.neutral5)),
                                    errorMaxLines: 2,
                                    prefixIcon: widget.prefixIcon == null
                                        ? null
                                        : (widget.prefixIcon is String)
                                            ? SvgPicture.asset(
                                                widget.prefixIcon ?? '',
                                                height: 20,
                                                width: 16,
                                                fit: BoxFit.scaleDown,
                                              )
                                            : widget.prefixIcon,
                                    suffixIcon: widget.suffixIcon != null
                                        ? widget.suffixIcon is String
                                            ? SvgPicture.asset(widget.suffixIcon!)
                                            : Icon(
                                                widget.suffixIcon,
                                                color: AppColor.black.withOpacity(0.25),
                                              )
                                        : null,
                                  ),
                                ),
                              )
                            : Container(),
      ],
    );
  }
}
