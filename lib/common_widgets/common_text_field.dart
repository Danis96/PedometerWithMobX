import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TextFieldType { passwordType, textAreaType, dropdownFieldType }

class FOSTextFormField extends StatefulWidget {
   FOSTextFormField({
    Key? key,
    this.label = '',
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.icon,
    this.errorTextEmpty,
    this.identical = true,
    required this.onChange,
    this.fKey,
    this.readOnly = false,
    this.type,
    this.errorTextConfirm,
    this.dropdownPressFunction,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.validation,
    this.hasTrailingIcon = false,
    this.borderColor = const Color.fromRGBO(102, 102, 102, 1),
    this.fillColor =  const Color.fromRGBO(102, 102, 102, 0.1),
    this.textHintColor = const Color.fromRGBO(102, 102, 102, 1),
  }) : super(key: key);

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  bool obscureText;
  final bool identical;
  final Widget? icon;
  final String? errorTextEmpty;
  final String? errorTextConfirm;
  final String? Function(String?)? onChange;
  final Function? dropdownPressFunction;
  final Function? onTap;
  final Key? fKey;
  final bool readOnly;
  final bool hasTrailingIcon;
  final TextFieldType? type;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validation;
  final TextCapitalization textCapitalization;
  final Color borderColor;
  final Color textHintColor;
  final Color fillColor;

  @override
  _FOSTextFormField createState() => _FOSTextFormField();
}

class _FOSTextFormField extends State<FOSTextFormField> {
  bool filled = true;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    bool isPasswordType() => widget.type == TextFieldType.passwordType;
    bool isDropDownType() => widget.type == TextFieldType.dropdownFieldType;
    return TextFormField(
      key: widget.key,
      maxLines: widget.type == TextFieldType.textAreaType ? 5 : 1,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      onTap: () => widget.onTap != null ? widget.onTap!() : print(''),
      onChanged: (String input) {
        if (widget.onChange != null) {
          widget.onChange!(input);
        }
        if (widget.controller != null) {
          setState(() {
            widget.controller!.text.isEmpty ? filled = true : filled = false;
          });
        }
      },
      readOnly: widget.readOnly,
      validator: widget.validation ??
          (String? value) {
            if (value!.isEmpty) {
              return widget.errorTextEmpty;
            } else {
              return null;
            }
          },
      obscureText:  widget.obscureText,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: widget.textHintColor, fontSize: 18, fontWeight: FontWeight.w200),
        suffixIcon: isDropDownType()
            ? IconButton(
                icon: const Icon(Icons.arrow_drop_down),
                color: const Color.fromRGBO(189, 195, 199, 1),
                onPressed: () => widget.dropdownPressFunction!(),
              )
            : isPasswordType()
                ? widget.hasTrailingIcon
                    ? IconButton(
                        icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                        color: const Color.fromRGBO(189, 195, 199, 1),
                        onPressed: () {
                          setState(() {
                            _obscure = !_obscure;
                            widget.obscureText = _obscure;
                          });
                        },
                      )
                    : const SizedBox()
                : widget.icon,
        hintText: widget.hintText,
        filled: filled,
        fillColor: widget.fillColor,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        errorStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

