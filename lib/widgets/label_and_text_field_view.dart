import 'package:flutter/material.dart';
import 'package:wechat/widgets/typical_text.dart';

import '../resources/dimens.dart';
import '../resources/strings.dart';

class LabelAndTextFieldView extends StatelessWidget {
  String label;
  String hint;
  Function onChanged;
  bool isSecure;
  bool isNumberType;
  TextEditingController? controller;


  LabelAndTextFieldView({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.isSecure = false,
    this.isNumberType = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            child: TextField(
              maxLines: 1,
                keyboardType: (isNumberType = true)
                    ?
                TextInputType.phone
                :
                TextInputType.text,
              // controller: TextEditingController(
              //     text: '',
              // ),

              onChanged: (text){
                onChanged(text);
                },
                decoration: InputDecoration(
                  hintText: hint,
                  labelText: label,
                  // ENTER_YOUR_PHONE_NUMBER,
                )
              // decoration: InputDecoration(
              //     border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
              //         borderSide: BorderSide(width: 1,color: Colors.grey)
              //     ),
              //     hintText: hint
              // ),
            )
        ),
      ],
    );
  }
}
