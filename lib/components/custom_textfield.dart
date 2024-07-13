import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomTextfieldExample extends StatelessWidget {
  final String label;
  final String hintText;
  final String name;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  const CustomTextfieldExample(
      {super.key,
      required this.name,
      required this.label,
      required this.hintText,
      required this.validator,
      this.initialValue
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: FormBuilderTextField(
        obscureText: label=="Password"?true:false,
        validator: validator,
        initialValue: initialValue,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: label,
            hintText: hintText,
            errorBorder: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(),
            focusedErrorBorder: OutlineInputBorder()), name: name,
      ),
    );
  }
}
