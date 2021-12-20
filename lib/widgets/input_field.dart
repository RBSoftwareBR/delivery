import 'package:flutter/material.dart';
import '../helpers/styles.dart';

InputDecoration defaultInputDecoration(
  context, {
  var icon,
  var hintText = corPrimaria,
  hintColor = corPrimaria,
  double fontsize = 12,
  error,
  var labelText,
  borderColor = corPrimaria,
  focusedBorderColor = corPrimaria,
  unableBorderColor = Colors.grey,
  fillColor,
  iconColor = corPrimaria,
  alingment,
  double radius = 5,
  floatingLabelBehavior = FloatingLabelBehavior.never,
  bool? filled,
  sufix,
}) {
  unableBorderColor ??= Colors.grey;
  focusedBorderColor ??= Colors.grey;
  borderColor ??= Colors.grey;
  FontStyle fontStyle = FontStyle.italic;
  OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
  OutlineInputBorder focusedborder = OutlineInputBorder(
      borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
  OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.red, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
  OutlineInputBorder unableBorder = OutlineInputBorder(
      borderSide: BorderSide(color: unableBorderColor, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
  TextStyle labelStyle = TextStyle(
    fontSize: fontsize,
    color: hintColor,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
  );
  if (error == null) {
    return InputDecoration(
        hintText: hintText,
        focusedBorder: focusedborder,
        hoverColor: Colors.transparent,
        filled: filled,
        enabledBorder: border,
        floatingLabelBehavior: floatingLabelBehavior,
        alignLabelWithHint: true,
        suffix: sufix,
        prefixIcon: icon == null ? null : Icon(icon, color: iconColor),
        isCollapsed: false,
        disabledBorder: unableBorder,
        contentPadding: EdgeInsets.symmetric(
            horizontal: icon == null ? 10 : 5, vertical: 10),
        labelText: labelText,
        focusColor: borderColor,
        focusedErrorBorder: focusedborder,
        errorBorder: errorBorder,
        labelStyle: labelStyle,
        errorStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        fillColor: fillColor,
        hintStyle: TextStyle(
            color: hintColor, fontSize: fontsize, fontStyle: fontStyle));
  }
  return InputDecoration(
      hintText: hintText,
      focusedBorder: focusedborder,
      hoverColor: borderColor,
      filled: filled,
      enabledBorder: focusedborder,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      alignLabelWithHint: true,
      prefixIcon: Icon(
        icon,
        color: Colors.red,
      ),
      isCollapsed: false,
      contentPadding:
          EdgeInsets.symmetric(horizontal: icon == null ? 10 : 5, vertical: 10),
      labelText: labelText,
      focusColor: borderColor,
      focusedErrorBorder: focusedborder,
      labelStyle: labelStyle,
      disabledBorder: unableBorder,
      errorBorder: errorBorder,
      border: border,
      errorText: error,
      errorStyle: const TextStyle(color: Colors.white),
      fillColor: fillColor,
      hintStyle: TextStyle(
          color: Colors.red, fontSize: fontsize, fontStyle: fontStyle));
}

TextFormField inputField(
    {String hint = '',
    String label = '',
    var validator,
    var keyboardType,
    onSubmitted,
    var controller,
    bool obscure = false,
    focusedBorderColor,
    var onSubmited,
    TextCapitalization? capitalization,
    bool expands = false,
    int minLines = 1,
    onChange,
    fillColor,
    int maxLines = 1,
    action = TextInputAction.done,
    TextStyle? style,
    borderColor = corPrimaria,
    context,
    bool enabled = true,
    double textSize = 18,
    icon,
    var color = Colors.black,
    textAlign = TextAlign.start,
    padding = const EdgeInsets.all(8),
    int? maxLength,
    floatingLabelBehavior,
    double radius = 0,
    Color hintColor = Colors.grey,
    error,
    textAlignVertical,
    unableBorderColor = Colors.grey,
    bool filled = false,
    sufix}) {
  style ??= TextStyle(
      fontSize: textSize,
      color: color,
      fontFamily: 'raleway',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    );
  return TextFormField(
    expands: expands,
    minLines: expands ? null : minLines,
    maxLines: expands ? null : maxLines,
    enabled: enabled,
    textAlignVertical: textAlignVertical,
    cursorColor: corPrimaria,
    cursorWidth: 2,
    enableInteractiveSelection: true,
    style: style,
    textCapitalization: capitalization ?? TextCapitalization.none,
    onFieldSubmitted: onSubmited,
    controller: controller,
    keyboardType: keyboardType,
    onChanged: onChange,
    obscureText: obscure,
    textInputAction: action,
    maxLength: maxLength,
    textAlign: textAlign,
    autocorrect: true,
    decoration: defaultInputDecoration(context,
        icon: icon,
        hintText: hint,
        focusedBorderColor: focusedBorderColor,
        filled: filled,
        sufix: sufix,
        floatingLabelBehavior: floatingLabelBehavior,
        unableBorderColor: unableBorderColor,
        labelText: label,
        fillColor: fillColor,
        borderColor: borderColor,
        fontsize: textSize,
        hintColor: hintColor,
        radius: radius,
        error: error),
  );
}
