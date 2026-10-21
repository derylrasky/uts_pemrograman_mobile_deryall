import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.validator,
    this.label = 'Nama kamu',
    this.hint = 'Masukkan nama kamu',
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final String? Function(String?) validator;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.person_outline_rounded),
      ),
    );
  }
}
