import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatefulWidget {


  final String helperText;
  final FormFieldValidator<String>  validator;
  final String hintText;
  final String initialValue;
  final GestureTapCallback onTap;
  final bool readOnly;
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Widget  prefix;
  final List<TextInputFormatter>  inputFormatters;
  final int maxLength;
  final ValueChanged<String> onChanged;
  const RoundedTextField({Key key, this.hintText, this.initialValue, this.onTap, this.readOnly=false, this.controller, this.labelText, this.keyboardType,  this.validator, this.prefix, this.helperText, this.inputFormatters, this.maxLength, this.onChanged}) : super(key: key);

  @override
  _RoundedTextFieldState createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
      //  left: 20.0,
     //   right: 20.0,
        bottom: 20.0,
      ),
      child: TextFormField(
        onChanged: widget.onChanged,
        maxLength: widget.maxLength,

        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        onTap: widget.onTap,
      //  textAlign: TextAlign.end,
        readOnly: widget.readOnly ,
        keyboardType: widget.keyboardType,
        initialValue: widget.initialValue,
        decoration: InputDecoration(

          helperText: widget.helperText,
          suffixIcon: widget.prefix,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            // width: 0.0 produces a thin "hairline" border
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: Colors.grey, width: 0.0),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
          hintText: widget.hintText,
          labelText: widget.hintText,
          isDense:true,


          //prefix:widget.prefix
          // prefix: Padding(
          //   padding: EdgeInsets.only(
          //     right: 15,
          //   ),
          //   child: Text(
          //     hintText,
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
        ),
        validator: widget.validator,
      ),
    );
  }
}

