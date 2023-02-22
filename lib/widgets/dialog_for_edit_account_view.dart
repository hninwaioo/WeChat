import 'package:flutter/material.dart';
import 'package:wechat/widgets/button_color_border_background.dart';

import '../pages/signup_data_view_page.dart';
import '../resources/dimens.dart';
import 'button_color_full_background.dart';

class DialogForEditAccountView extends StatefulWidget {
  const DialogForEditAccountView({Key? key}) : super(key: key);

  @override
  State<DialogForEditAccountView> createState() => _DialogForEditAccountViewState();
}

class _DialogForEditAccountViewState extends State<DialogForEditAccountView> {
  String genderType = "MALE";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_2),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Name",
                labelText: "Name",
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              // validator: (String? value) {
              //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              // },
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: "Phone Number",
                labelText: "Phone Number",
              ),
              onSaved: (String? value) {
                // This optional block of code can be used to run
                // code when the user saves the form.
              },
              // validator: (String? value) {
              //   return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
              // },
            ),
          ),

          // DateOfBirthSectionView(),

          ChooseGenderSectionView(
            selectedMale: "MALE",
            selectedFemale: "FEMALE",
            selectedOther: "OTHER",
            genderType: genderType,
            onSelectedMale: (selectedGender) {
              setState(() {
                genderType = selectedGender??"";
                // widget.onSelectedVerticalListView(widget.viewType);
              });
            },
            onSelectedFemale: (selectedGender) {
              setState(() {
                genderType = selectedGender??"";
                // widget.onSelectedLargeGridView(widget.viewType);
              });
            },
            onSelectedOther: (selectedGender) {
              setState(() {
                genderType = selectedGender??"";
                // widget.onSelectedSmallGridView(widget.viewType);
              });
            },
          ),

          SizedBox(height: MARGIN_MEDIUM_2),

          Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
              child: CancelAndSaveButtonSectionView()
          )
        ],
      )
    );
  }
}

class CancelAndSaveButtonSectionView extends StatelessWidget {
  const CancelAndSaveButtonSectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        GestureDetector(
            onTap: (){
              // _selectDate(context);
              // _navigateToHomeNavigationViewScreen(context);
            },
            child: ButtonColorBorderBackground(btnText: "Cancel",marginValue: MARGIN_MEDIUM_2,)
        ),

        Spacer(),

        GestureDetector(
            onTap: (){
              // _selectDate(context);
              // _navigateToHomeNavigationViewScreen(context);
            },
            child: ButtonColorFullBackground(btnText: "Save", marginValue: MARGIN_XLARGE,)
        ),
      ],
    );
  }
}

