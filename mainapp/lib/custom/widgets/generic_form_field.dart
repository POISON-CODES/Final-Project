
part of 'custom_global_widgets.dart';

class CustomFormField extends FormFields {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscure;

  const CustomFormField({
    super.key,
    super.obscureText = false,
    super.textInputType = TextInputType.text,
    super.enabled = true,
    this.suffixIcon,
    this.validator,
    super.fieldType = FieldType.text,
    super.isRequired = true,
    required this.controller,
    required super.label,
  }) : obscure = obscureText ?? false;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'obscureText': obscureText,
      'textInputType': textInputType.toString(),
      'labelText': label,
      'enabled': enabled,
      'suffixIcon': suffixIcon?.toString(),
      'validator': validator?.toString(),
    };
  }

  // factory CustomFormField.fromMap(Map<String, dynamic> map) {
  //   return CustomFormField(
  //     controller: TextEditingController.fromMap(map['controller'] as Map<String,dynamic>),
  //     obscureText: map['obscureText'] as bool,
  //     textInputType: TextInputType.fromMap(map['textInputType'] as Map<String,dynamic>),
  //     labelText: map['labelText'] as String,
  //     enabled: map['enabled'] as bool,
  //     suffixIcon: map['suffixIcon'] != null ? Widget.fromMap(map['suffixIcon'] as Map<String,dynamic>) : null,
  //     validator: map['validator'] != null ? String? Function(String?).fromMap(map['validator'] as Map<String,dynamic>) : null,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory CustomFormField.fromJson(String source) => CustomFormField.fromMap(json.decode(source) as Map<String, dynamic>);
}

class _CustomFormFieldState extends State<CustomFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText!;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      validator: widget.validator,
      keyboardAppearance: Brightness.dark,
      obscuringCharacter: '*',
      keyboardType: widget.textInputType,
      controller: widget.controller,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: widget.suffixIcon ??
              (widget.obscure
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
                  : null),
        ), // Hide the suffix icon if obscureText is false
        labelText: widget.label, // Removed unnecessary space
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
