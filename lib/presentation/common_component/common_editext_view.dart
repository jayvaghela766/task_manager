import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable text input field widget.
class TextInputField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? textController;
  final Widget? icons;
  final String errorText;
  final bool? passwordVisibility;
  final bool readOnly;
  final bool isEnable;
  final String hintText;
  final VoidCallback? onTap;
  final Function(String?)? onChanged;
  final String? calledFrom;
  final TextInputType textInputType;
  final int inputValue;
  final bool isMaxNeeded;
  final bool isEventScreen;
  final Function(String)? onFieldSubmitted;
  final Function()? onPassWordHideShowPressed;
  final bool isSearched;
  final bool? isPasswordField;

  /// Constructs a [TextInputField].
  const TextInputField({
    super.key,
    this.focusNode,
    this.textController,
    this.onFieldSubmitted,
    this.icons,
    this.passwordVisibility,
    required this.errorText,
    this.readOnly = false,
    required this.hintText,
    this.onTap,
    this.isSearched = false,
    this.isEventScreen = false,
    this.onChanged,
    this.calledFrom,
    this.onPassWordHideShowPressed,
    this.isEnable = true,
    this.textInputType = TextInputType.text,
    this.inputValue = 5000,
    this.isMaxNeeded = false,
    this.isPasswordField = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Text input field wrapped with rounded border
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          child: SizedBox(
            height: 50,
            child: TextFormField(
              readOnly: readOnly,
              onTap: onTap,
              inputFormatters: textInputType == TextInputType.number
                  ? [
                FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
                LengthLimitingTextInputFormatter(inputValue),
              ]
                  : [
                LengthLimitingTextInputFormatter(inputValue),
              ],
              keyboardType: textInputType,
              obscureText: isPasswordInvisible(isPasswordField!),
              controller: textController,
              autofocus: false,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(focusNode);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                filled: true,
                hintText: hintText,
                prefixIcon: icons,
              ),
              onChanged: onChanged,
            ),
          ),
        ),
        /// Display error text if present
        Visibility(
          visible: errorText.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  /// Determines whether the password should be visible or hidden.
  bool isPasswordInvisible(bool isPasswordField) {
    if (isPasswordField) {
      return passwordVisibility ?? true;
    }
    return false;
  }
}
