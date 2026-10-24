import 'package:flutter/material.dart';

enum InputFieldType { name, email, password }

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;

  // Для сравнения паролей в двух полях ввода
  final TextEditingController? matchController;
  final String? mismatchText;

  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.matchController,
    this.mismatchText,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Поле не может быть пустым";
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(r'^[A-Za-zА-Яа-яЁё\s]+$'); // только буквы и пробелы
        if (!reg.hasMatch(value)) {
          return "Имя должно содержать только буквы и пробелы";
        }
        break;

      case InputFieldType.email:
        final reg = RegExp(r'^[\w.+-]+@[A-Za-z0-9-]+\.[A-Za-z0-9.-]+$');
        if (!reg.hasMatch(value)) {
          return "Введите корректный email";
        }
        break;

      case InputFieldType.password:
        final reg = RegExp(r'^(?=.*[A-Za-zА-Яа-я])(?=.*\d)(?=.*[+_\-]).{6,}$');
        if (!reg.hasMatch(value)) {
          return "Пароль должен быть не менее 6 символов и содержать буквы, "
              "цифры и символы (+, _, -)";
        }
        if (widget.matchController != null &&
            value != widget.matchController!.text) {
          return widget.mismatchText ?? "Пароли не совпадают";
        }
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.inputType == InputFieldType.password;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: isPassword && _hidePassword,
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      style: const TextStyle(
        color: Color(0xFF192252),
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText.isEmpty ? null : widget.labelText,
        labelStyle: const TextStyle(color: Color(0xFF424F7B), fontSize: 16),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _hidePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _hidePassword = !_hidePassword);
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF424F7B), width: 1.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF192252), width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: _validator,
    );
  }
}
