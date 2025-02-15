part of 'custom_global_widgets.dart';



class CustomFormField extends FormFields {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType textInputType;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    required this.controller,
    required this.labelText,
    this.validator,
  }) : super();

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardAppearance: Brightness.dark,
      obscuringCharacter: '*',
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null, // Hide the suffix icon if obscureText is false
        labelText: widget.labelText, // Removed unnecessary space
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
