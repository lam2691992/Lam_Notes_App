import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.labelText,
    this.controller,
    this.initText,
    this.readOnly,
    this.autoFocus = false,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.trailing,
    this.prefixIcon,
    this.suffixIcon,
    this.backgroundColor,
    this.hintText,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    this.keyboardType,
    this.inputFormatters,
    this.focusNode,
    this.maxLength,
    this.maxLines,
    this.textInputAction,
  }) : super(key: key);
  final String? initText;
  final String? labelText;
  final TextEditingController? controller;
  final bool? readOnly;
  final bool autoFocus;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Widget? trailing;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final String? hintText;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry contentPadding;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final int? maxLines;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController _controller;

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initText != widget.initText) {
      _setText(widget.initText);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = widget.controller ?? TextEditingController();
    if (widget.initText != null) {
      _controller.text = widget.initText!;
    }
  }

  void _setText(String? text) {
    if (text != null) {
      _controller.text = text;
      _controller.selection = TextSelection.fromPosition(TextPosition(offset: text.length));
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign,
          controller: _controller,
          readOnly: widget.readOnly ?? false,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          maxLines: widget.maxLines,
          // cursorColor: colors.defaultColor,
          // style: widget.textStyle ?? textTheme.body16Default,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 18,
              height: 20 / 18,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6F787E),
            ),
            contentPadding: widget.contentPadding,
            border: InputBorder.none,
            labelText: widget.labelText,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            filled: widget.backgroundColor != null,
            fillColor: widget.backgroundColor,
          ),
        ),
        if (widget.trailing != null)
          Align(
            alignment: Alignment.centerRight,
            child: widget.trailing,
          ),
      ],
    );
  }
}
