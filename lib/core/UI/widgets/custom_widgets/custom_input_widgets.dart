import 'package:bisherproject/core/logical/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:styled_widget/styled_widget.dart';
import 'package:collection/collection.dart';
import '../../../logical/errors/errors_model.dart';
import '../../../logical/utils/validator.dart';
import '../../styles/colors.dart';
import '../../styles/styles.dart';
import 'custom_widgets.dart';

class CustomInputField extends StatefulWidget {
  const CustomInputField({
    super.key,
    this.initValue,
    this.hint,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.outerLabel,
    this.isRequired = false,
    this.isObscureText = false,
    this.isAutoValidate = false,
    this.enabled = true,
    this.errorDictionary,
    this.action = TextInputAction.next,
    this.keyboardType,
    this.errorDictionaryKey,
    this.errorText,
    this.isEmail = false,
    this.customKey,
    this.hPadding,
    this.readOnly = false,
    this.isNumber = false,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.onTap,
    this.suffixIcon,
    this.inputFormatters
  });
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final double? hPadding;
  final Key? customKey;
  final bool isRequired;
  final TextInputType? keyboardType;
  final TextInputAction action;
  final bool isObscureText, isEmail, isNumber, isAutoValidate, readOnly, enabled;
  final String? initValue, outerLabel, hint, errorText, errorDictionaryKey;
  final ErrorDictionary? errorDictionary;
  final void Function(String?)? onSaved, onChanged;
  final String? Function(String?)? validator;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late final TextInputType type;
  @override
  void initState() {
    if (widget.initValue != null && widget.controller != null) widget.controller!.text = widget.initValue!;

    if (widget.keyboardType != null) {
      type = widget.keyboardType!;
    } else if (widget.isNumber) {
      type = const TextInputType.numberWithOptions(signed: false, decimal: true);
    } else if (widget.isEmail) {
      type = TextInputType.emailAddress;
    } else {
      type = TextInputType.text;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.outerLabel?.isNotEmpty != null,
          child: Column(
            children: [
              TextTr(
                widget.outerLabel ?? '',
                style: const TextStyle(
                  color: MyColors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6)
            ],
          ),
        ),
        TextFormField(
          inputFormatters: widget.inputFormatters,
          key: widget.customKey,
          maxLength: widget.maxLength,
          initialValue: widget.controller != null ? null : widget.initValue,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          controller: widget.controller,
          obscureText: widget.isObscureText,
          style: const TextStyle(fontSize: 16, color: MyColors.black),
          keyboardType: type,
          autovalidateMode: widget.isAutoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          textInputAction: widget.action,
          // inputFormatters: [LengthLimitingTextInputFormatter(widget.maxLength)],
          maxLines: widget.maxLines,
          onTap: widget.onTap,
          decoration: getFieldDecoration(
            hint: widget.hint,
            hPadding: widget.hPadding,
            suffixIcon: widget.suffixIcon,
          ),
          validator: (value) {
            final message = (widget.errorDictionary ?? []).toList().firstWhereOrNull((element) {
              return element.key == widget.errorDictionaryKey;
            })?.value;
            if (message != null) return message;

            if (widget.errorText != null && widget.errorText!.isNotEmpty && widget.errorText != '200') {
              return widget.errorText;
            }
            if (widget.isRequired && (value == null || value.isEmpty)) return 'This field is required';

            if (widget.isEmail && !Validator.email.isValid(value)) return 'Enter a valid email address';

            return widget.validator?.call(value);
          },
          onSaved: (val) => widget.onSaved?.call(val?.trim()),
          onChanged: (val) => widget.onChanged?.call(val.trim()),
        ),
      ],
    );
  }
}

class CustomPopupWidget<T> extends StatefulWidget {
  const CustomPopupWidget({
    required this.onSelect,
    required this.items,
    required this.hint,
    this.initValue,
    super.key,
  });
  final T? initValue;
  final List<T> items;
  final String hint;
  final void Function(T) onSelect;

  @override
  State<CustomPopupWidget<T>> createState() => _CustomPopupWidgetState<T>();
}

class _CustomPopupWidgetState<T> extends State<CustomPopupWidget<T>> {
  final GlobalKey<PopupMenuButtonState> _key = GlobalKey();
  final txtCon = TextEditingController();
  T? _value;
  @override
  void initState() {
    if (widget.initValue != null) txtCon.text = getValueStr(widget.initValue)!;
    _value = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      key: _key,
      offset: const Offset(0, 6),
      initialValue: _value,
      itemBuilder: (_) => widget.items
          .map((item) => PopupMenuItem(
                value: item,
                child: Text(getValueStr(item)!),
              ))
          .toList(),
      onSelected: (val) {
        _value = val;
        txtCon.text = getValueStr(val) ?? '';
        setState(() {});
        widget.onSelect(val);
      },
      child: CustomInputField(
        readOnly: true,
        hint: widget.hint,
        controller: txtCon,
        suffixIcon: const Icon(Icons.arrow_drop_down),
        onTap: () {
          _key.currentState?.showButtonMenu();
        },
      ),
    );
  }

  String? getValueStr(e) {
    String str;
    if (e == null) return null;
    if (e is Enum) {
      str = e.name.characters.string;
    } else {
      str = e;
    }
    str = str.replaceFirst(str.characters.first, str.characters.first.toUpperCase());
    return str;
  }
}

class CustomDropdownField<T> extends StatelessWidget {
  const CustomDropdownField({
    required this.onSelect,
    required this.items,
    required this.hint,
    this.initValue,
    super.key,
    this.isRequired = false,
    this.isFilled = false,
  });

  final bool isRequired, isFilled;
  final T? initValue;
  final List<T> items;
  final String hint;
  final void Function(T) onSelect;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        value: initValue,
        hint: TextTr(hint, style: const TextStyle(color: MyColors.black, fontSize: 16)),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 40,
          color: MyColors.black,
        ).translate(offset: Offset(0, -1.hPercent)),
        decoration: getFieldDecoration(
          filled: true,
          hPadding: 0,
          radius: 10,
        ),
        validator: (value) {
          if (isRequired && value == null) return 'This field is required';
          return null;
        },
        onChanged: (val) {
          if (val == null) return;
          onSelect(val);
        },
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    getValueStr(item)!,
                    style: infoStyle(),
                  ),
                ))
            .toList(),
      ),
    );
  }

  String? getValueStr(e) {
    String str;
    if (e == null) return null;
    if (e is Enum) {
      str = e.name.characters.string;
    } else {
      str = e.toString();
    }
    str = str.replaceFirst(str.characters.first, str.characters.first.toUpperCase());
    return str;
  }
}
