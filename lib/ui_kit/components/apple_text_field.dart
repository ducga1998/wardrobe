import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apple_colors.dart';
import '../theme/apple_typography.dart';

/// Apple-style text input field
class AppleTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final IconData? suffixIcon;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final bool clearButtonMode;

  const AppleTextField({
    Key? key,
    this.controller,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.suffix,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.contentPadding,
    this.style,
    this.clearButtonMode = false,
  }) : super(key: key);

  @override
  State<AppleTextField> createState() => _AppleTextFieldState();
}

class _AppleTextFieldState extends State<AppleTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _obscureText = widget.obscureText;

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: AppleTypography.footnote.copyWith(
              color: isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          style: widget.style ?? AppleTypography.body.copyWith(
            color: isDark ? AppleColors.labelDark : AppleColors.label,
          ),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            errorText: widget.errorText,
            helperText: widget.helperText,
            filled: true,
            fillColor: isDark
                ? AppleColors.tertiarySystemFillDark
                : AppleColors.tertiarySystemFill,
            contentPadding: widget.contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

            // Prefix
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: _isFocused
                        ? (isDark ? AppleColors.systemBlueDark : AppleColors.systemBlue)
                        : (isDark ? AppleColors.tertiaryLabelDark : AppleColors.tertiaryLabel),
                  )
                : null,
            prefix: widget.prefix,

            // Suffix
            suffixIcon: _buildSuffixIcon(isDark),
            suffix: widget.suffix,

            // Borders
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? AppleColors.systemBlueDark : AppleColors.systemBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? AppleColors.systemRedDark : AppleColors.systemRed,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: isDark ? AppleColors.systemRedDark : AppleColors.systemRed,
                width: 2,
              ),
            ),

            // Text styles
            hintStyle: AppleTypography.body.copyWith(
              color: isDark ? AppleColors.tertiaryLabelDark : AppleColors.tertiaryLabel,
            ),
            errorStyle: AppleTypography.footnote.copyWith(
              color: isDark ? AppleColors.systemRedDark : AppleColors.systemRed,
            ),
            helperStyle: AppleTypography.footnote.copyWith(
              color: isDark ? AppleColors.secondaryLabelDark : AppleColors.secondaryLabel,
            ),
          ),
        ),
      ],
    );
  }

  Widget? _buildSuffixIcon(bool isDark) {
    final icons = <Widget>[];

    // Clear button
    if (widget.clearButtonMode && _controller.text.isNotEmpty && _isFocused) {
      icons.add(
        IconButton(
          icon: Icon(
            Icons.cancel,
            color: isDark ? AppleColors.tertiaryLabelDark : AppleColors.tertiaryLabel,
            size: 20,
          ),
          onPressed: () {
            _controller.clear();
            if (widget.onChanged != null) {
              widget.onChanged!('');
            }
          },
        ),
      );
    }

    // Password visibility toggle
    if (widget.obscureText) {
      icons.add(
        IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: isDark ? AppleColors.tertiaryLabelDark : AppleColors.tertiaryLabel,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      );
    }

    // Custom suffix icon
    if (widget.suffixIcon != null) {
      icons.add(
        Icon(
          widget.suffixIcon,
          color: _isFocused
              ? (isDark ? AppleColors.systemBlueDark : AppleColors.systemBlue)
              : (isDark ? AppleColors.tertiaryLabelDark : AppleColors.tertiaryLabel),
        ),
      );
    }

    if (icons.isEmpty) return null;
    if (icons.length == 1) return icons[0];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: icons,
    );
  }
}

/// Apple-style search field
class AppleSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;

  const AppleSearchField({
    Key? key,
    this.controller,
    this.placeholder = 'Search',
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.autofocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppleTextField(
      controller: controller,
      placeholder: placeholder,
      prefixIcon: Icons.search,
      clearButtonMode: true,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onSubmitted: onSubmitted,
      autofocus: autofocus,
    );
  }
}
