import 'package:flutter/material.dart';
import '../../logical/errors/errors_model.dart';
import '../../logical/utils/validator.dart';

import 'custom_widgets/custom_input_widgets.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.onSaved,
    this.errorDictionary,
    this.showStrongMetric = false,
    this.label,
    this.hint,
    this.errorDictionaryKey,
    this.controller,
  });
  final TextEditingController? controller;
  final String? errorDictionaryKey, label, hint;
  final void Function(String?) onSaved;
  final bool showStrongMetric;
  final ErrorDictionary? errorDictionary;
  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  double passwordStrength = 0;
  String passwordStrengthHint = '';
  final key = GlobalKey<FormFieldState>();
  @override
  void didUpdateWidget(covariant PasswordField oldWidget) {
    if (!widget.showStrongMetric) {
      passwordStrength = 0;
      passwordStrengthHint = '';
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomInputField(
          customKey: key,
          controller: widget.controller,
          outerLabel: widget.label ?? 'Password',
          hint: widget.hint ?? 'Input password',
          errorDictionaryKey: widget.errorDictionaryKey ?? 'password',
          isObscureText: true,
          isRequired: true,
          errorDictionary: widget.errorDictionary,
          errorText: passwordStrengthHint,
          onChanged: (value) => widget.showStrongMetric ? validatePassword(value) : null,
          onSaved: widget.onSaved,
        ),
        Visibility(
          visible: showMetric,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 12, 12, 0),
            child: LinearProgressIndicator(
              value: passwordStrength / 4,
              backgroundColor: Colors.grey[300],
              minHeight: 4,
              color: passwordStrength <= 1
                  ? Colors.red
                  : passwordStrength == 2
                      ? Colors.yellow
                      : passwordStrength == 3
                          ? Colors.blue
                          : Colors.green,
            ),
          ),
        ),
      ],
    );
  }

  bool get showMetric => passwordStrength > 0 && widget.showStrongMetric;

  validatePassword(String? pass) {
    String password = pass?.trim() ?? '';
    passwordStrength = 0;
    passwordStrengthHint = '';
    if (password.isEmpty) {
      passwordStrength = 0;
      passwordStrengthHint = 'Password must not be empty';
      updateValidationMessage();
      return passwordStrengthHint;
    } else {
      passwordStrength = 1;
    }

    if (password.length >= 8) {
      passwordStrength += 1;
    } else {
      passwordStrengthHint = 'Password must be at least 8 characters\n';
    }

    if (Validator.password.isValid(password) && password.length >= 8) {
      passwordStrength = 4;
      passwordStrengthHint = '200';
      updateValidationMessage();
      return null;
    } else {
      if (password.contains(RegExp(r'(?=.*[a-z])(?=.*[A-Z])'))) {
        passwordStrength += 1;
      } else {
        passwordStrengthHint += 'Password must contains lowercase and uppercase letters\n';
      }

      if (password.contains(RegExp(r'[0-9]')) && password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_]'))) {
        passwordStrength += 1;
      } else {
        passwordStrengthHint += 'Password must contains numbers and symbols';
      }
    }
    passwordStrengthHint = passwordStrengthHint.trim();
    updateValidationMessage();
    return passwordStrengthHint;
  }

  Future<void> updateValidationMessage() async {
    setState(() {});
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      key.currentState!.validate();
    });
  }
}
