import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wechat/bloc/register_bloc.dart';
import 'package:wechat/pages/verify_phone_number_and_get_otp_view_page.dart';
import 'package:wechat/pages/wechat_home_navigation_view_page.dart';
import 'package:wechat/resources/strings.dart';
import 'package:wechat/widgets/back_button_action.dart';
import 'package:wechat/widgets/button_color_full_background.dart';
import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../widgets/label_and_text_field_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/typical_text.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinner_picker/flutter_spinner_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpDataViewPage extends StatefulWidget {
  String phoneNumber;
  String otpCode;
  SignUpDataViewPage({required this.phoneNumber, required this.otpCode});

  @override
  State<SignUpDataViewPage> createState() => _SignUpDataViewPageState();
}

class _SignUpDataViewPageState extends State<SignUpDataViewPage> {
  String genderType = "MALE";
  String completeBirthDate = "";
  String birth_day = "";
  String birth_month = "";
  String birth_year = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterBloc(),
        child: Selector<RegisterBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(children: [
            Scaffold(
              backgroundColor: PRIMARY_BACKGROUND_COLOR,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: PRIMARY_BACKGROUND_COLOR,
                leading: BackButtonAction(),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset("assets/images/hi_icon.svg"),
                          SizedBox(
                            height: MARGIN_SMALL,
                          ),
                          TypicalText(CREATE_A_NEW_ACCOUNT, PRIMARY_COLOR,
                              TEXT_REGULAR),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_MEDIUM_2,
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
                      child: Consumer<RegisterBloc>(
                        builder: (context, bloc, child) =>
                            Consumer<RegisterBloc>(
                                builder: (context, bloc, child) => TextField(
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    // controller: TextEditingController(
                                    //     text: '',
                                    // ),

                                    onChanged: (text) {
                                      bloc.onUserNameChanged(text);
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      labelText: "Name",
                                    ))),
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
                      child: Consumer<RegisterBloc>(
                          builder: (context, bloc, child) => TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              // controller: TextEditingController(
                              //     text: '',
                              // ),

                              onChanged: (text) {
                                bloc.onEmailChanged(text);
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Your Email",
                                labelText: "Email",
                                // ENTER_YOUR_PHONE_NUMBER,
                              ))),
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context, bloc, child) => DateOfBirthSectionView(
                          onSelectedDay: (birthDay) {
                            bloc.onBirthDateDayChanged(birthDay);
                            birth_day = birthDay;

                            completeBirthDate = birth_day +
                                "/" +
                                birth_month +
                                "/" +
                                birth_year;
                            bloc.onBirthDateChanged(completeBirthDate);
                          },
                          onSelectedMonth: (birthMonth) {
                            bloc.onBirthDateMonthChanged(birthMonth);
                            birth_month = birthMonth;
                            completeBirthDate = birth_day +
                                "/" +
                                birth_month +
                                "/" +
                                birth_year;
                            bloc.onBirthDateChanged(completeBirthDate);
                          },
                          onSelectedYear: (birthYear) {
                            bloc.onBirthDateYearChanged(birthYear);
                            birth_year = birthYear;
                            completeBirthDate = birth_day +
                                "/" +
                                birth_month +
                                "/" +
                                birth_year;

                            bloc.onBirthDateChanged(completeBirthDate);
                          },
                          dateValue: birth_day,
                          monthValue: birth_month,
                          yearValue: birth_year,
                          completeBirthDate: completeBirthDate
                          // birth_day+"/"+birth_month+"/"+birth_year,

                          ),
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context, bloc, child) =>
                          ChooseGenderSectionView(
                        selectedMale: "MALE",
                        selectedFemale: "FEMALE",
                        selectedOther: "OTHER",
                        genderType: genderType,
                        onSelectedMale: (selectedGender) {
                          setState(() {
                            genderType = selectedGender ?? "";
                            // widget.onSelectedVerticalListView(widget.viewType);
                            bloc.onGenderChanged(selectedGender ?? "");
                          });
                        },
                        onSelectedFemale: (selectedGender) {
                          setState(() {
                            genderType = selectedGender ?? "";
                            // widget.onSelectedLargeGridView(widget.viewType);
                            bloc.onGenderChanged(selectedGender ?? "");
                          });
                        },
                        onSelectedOther: (selectedGender) {
                          setState(() {
                            genderType = selectedGender ?? "";
                            // widget.onSelectedSmallGridView(widget.viewType);
                            bloc.onGenderChanged(selectedGender ?? "");
                          });
                        },
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_LARGE),
                      child: Consumer<RegisterBloc>(
                          builder: (context, bloc, child) => TextField(
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              // controller: TextEditingController(
                              //     text: '',
                              // ),

                              onChanged: (text) {
                                bloc.onPasswordChanged(text);
                              },
                              decoration: InputDecoration(
                                hintText: "Password",
                                labelText: "Password",
                                // ENTER_YOUR_PHONE_NUMBER,
                              ))),
                    ),
                    SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context, bloc, child) =>
                          CheckAgreeToTermAndServiceSectionView(
                        isCheckTerms: (isCheck) {
                          bloc.onCheckTermAndService(isCheck);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_XLARGE,
                    ),
                    Consumer<RegisterBloc>(
                      builder: (context, bloc, child) => Center(
                        child: Container(
                          width: 120,
                          height: 50,
                          child: Material(
                            //Wrap with Material
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            elevation: 1.0,
                            color: PRIMARY_COLOR,
                            clipBehavior: Clip.antiAlias, // Add This
                            child: MaterialButton(
                              minWidth: 200.0,
                              height: 35,
                              color:
                                  (bloc.isCheck) ? PRIMARY_COLOR : Colors.grey,

                              // (bloc.isCheck)?
                              // disabledColor: Colors.grey
                              // :
                              // enableFeedback: true,
                              child: Text('Sign Up',
                                  style: new TextStyle(
                                      fontSize: 16.0, color: Colors.white)),
                              onPressed: () {
                                (bloc.isCheck)
                                    ? bloc
                                        .onTapRegister(
                                            widget.phoneNumber, widget.otpCode)
                                    .then((value){
                                      _navigateToHomeNavigationViewScreen(context);
                                      // Navigator.pop(context);
                                    })
                                    .catchError((error) =>
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(error
                                            .toString())
                                    ))
                                )
                                    : null;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MARGIN_XXLARGE,
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                    color: Colors.black12,
                    child: Center(
                      child: LoadingView(),
                    )))
          ]),
        ));
  }

  TextEditingController _datecontroller = new TextEditingController();

  var myFormat = DateFormat('d-MM-yyyy');

  DateTime date = DateTime.now();
  late List<String> yearList;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    setState(() {
      date = picked ?? date;
      yearList.add(date.year.toString() ?? "");
      print("YEARLIST=>${yearList}");
    });
  }

  Future<dynamic> _navigateToHomeNavigationViewScreen(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WeChatHomeNavigationViewPage()));
  }
}

class DateOfBirthSectionView extends StatefulWidget {
  Function(String) onSelectedDay;
  Function(String) onSelectedMonth;
  Function(String) onSelectedYear;
  String dateValue;
  String monthValue;
  String yearValue;
  String completeBirthDate;

  DateOfBirthSectionView(
      {required this.onSelectedDay,
      required this.onSelectedMonth,
      required this.onSelectedYear,
      required this.dateValue,
      required this.monthValue,
      required this.yearValue,
      required this.completeBirthDate});

  @override
  State<DateOfBirthSectionView> createState() => _DateOfBirthSectionViewState();
}

class _DateOfBirthSectionViewState extends State<DateOfBirthSectionView> {
  String dateValue = '1';
  String monthValue = '1';
  String yearValue = '1990';

  List<String> dateItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31'
  ];
  List<String> monthItems = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  DateTime dt1 = DateTime.parse("2021-12-23 11:47:00");
  DateTime dt2 = DateTime.parse("2018-09-12 10:57:00");

  final _currentDate = DateTime.now();
  final _completeDate = DateFormat("yyyy-MM-dd");
  final _dayName = DateFormat('EE');
  final _dayFormatter = DateFormat('dd');
  final _monthFormatter = DateFormat('MMM');

  late Duration diff;

  String? firstSelectedDate;
  String? completeDate;

  String? day;
  String? month;
  String? dayDate;

  List<String> yearsItems = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectDate;
      diff = dt1.difference(dt2);

      print("DIFFERENT DATE=>${diff}");
      debugPrint("Difference in Days:=>${diff.inDays.toString()}");

      final currentYear = _currentDate.year;
      print("COMPLETEDATE=>${currentYear}");

      int resultYear = currentYear - 1990;
      print("COMPLETEDATE=>${resultYear}");

      for (int i = 0; i < resultYear + 1; i++) {
        var d = 1990 + i;
        print("COMPLETEDATE_yearsList==>${d}");

        yearsItems.add(d.toString());

        print("COMPLETEDATEyearsList==>${yearsItems}");
      }
      print("COMPLETEDATEyearsList=>${yearsItems}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return
        // Consumer<RegisterBloc>(
        // builder: (context,bloc,child) =>
        Container(
      margin: EdgeInsets.symmetric(
          horizontal: MARGIN_MEDIUM_2, vertical: MARGIN_MEDIUM_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypicalText("Date of Birth", PRIMARY_HINT_COLOR, TEXT_REGULAR),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              // Expanded(
              //   child:
              Card(
                elevation: 1.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: MARGIN_SMALL, vertical: MARGIN_SMALL),
                  child: Center(
                    child: DropdownButton<String>(
                      hint: Text("Days"),
                      // value: dateValue,
                      // widget.dateValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: PRIMARY_COLOR,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      // underline: null,
                      underline: Container(
                        height: 2,
                        color: Colors.white,
                      ),
                      onChanged: (String? birthday) {
                        setState(() {
                          widget.dateValue = birthday ?? "";
                          dateValue = birthday ?? "";

                          // bloc.onBirthDateDayChanged(birthday??"");
                          widget.onSelectedDay(birthday ?? "");
                          // widget.completeBirthDate = widget.dateValue+"/"+widget.monthValue+"/"+widget.yearValue;
                        });
                      },
                      items: dateItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: TEXT_REGULAR),
                          ),
                        );
                      }).toList(),
                      value: dateValue,
                      // widget.dateValue,
                    ),
                  ),
                ),
              ),
              // ),

              Expanded(
                child: Card(
                  elevation: 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: MARGIN_SMALL),
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text("months"),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        // underline: null,
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        onChanged: (String? birthMonth) {
                          setState(() {
                            widget.monthValue = birthMonth ?? "";
                            monthValue = birthMonth ?? "";

                            // bloc.onBirthDateMonthChanged(birthMonth??"");
                            widget.onSelectedMonth(birthMonth??"");
                            // widget.completeBirthDate = widget.dateValue+"/"+widget.monthValue+"/"+widget.yearValue;
                          });
                        },
                        items: monthItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(fontSize: TEXT_REGULAR)),
                          );
                        }).toList(),
                        value: monthValue,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  elevation: 1.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: MARGIN_SMALL),
                    child: Center(
                      child: DropdownButton<String>(
                        hint: Text("Years"),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: PRIMARY_COLOR,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        // underline: null,
                        underline: Container(
                          height: 2,
                          color: Colors.white,
                        ),
                        onChanged: (String? birthYear) {
                          setState(() {
                            widget.yearValue = birthYear ?? "";
                            yearValue = birthYear ?? "";
                            widget.onSelectedYear(birthYear??"");
                            // widget.completeBirthDate = widget.dateValue+"/"+widget.monthValue+"/"+widget.yearValue;
                            // bloc.onBirthDateYearChanged(birthYear??"");
                          });
                        },
                        items: yearsItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(fontSize: TEXT_REGULAR)),
                          );
                        }).toList(),
                        value: yearValue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    // );
  }

  TextEditingController _datecontroller = new TextEditingController();

  var myFormat = DateFormat('d-MM-yyyy');

  late DateTime date;
  // late List<String> yearList;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    setState(() {
      date = picked ?? date;
      // yearList.add(date.year.toString());
      // print("YEARLIST=>${yearList}");
    });
  }
}

class ChooseGenderSectionView extends StatefulWidget {
  String? selectedMale;
  String? selectedFemale;
  String? selectedOther;
  Function(String?) onSelectedMale;
  Function(String?) onSelectedFemale;
  Function(String?) onSelectedOther;

  String? genderType;

  ChooseGenderSectionView({
    required this.onSelectedMale,
    required this.onSelectedFemale,
    required this.onSelectedOther,
    required this.genderType,
    required this.selectedMale,
    required this.selectedFemale,
    required this.selectedOther,
  });

  @override
  State<ChooseGenderSectionView> createState() =>
      _ChooseGenderSectionViewState();
}

class _ChooseGenderSectionViewState extends State<ChooseGenderSectionView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TypicalText("Gender", PRIMARY_HINT_COLOR, TEXT_REGULAR),
          SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: TypicalText("Male", PRIMARY_COLOR, TEXT_REGULAR),
                    value: "MALE",
                    groupValue: widget.genderType,
                    onChanged: (value) {
                      widget.onSelectedMale("MALE");
                      setState(() {
                        widget.selectedMale = value.toString();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: TypicalText("Female", PRIMARY_COLOR, TEXT_REGULAR),
                    value: "FEMALE",
                    groupValue: widget.genderType,
                    onChanged: (value) {
                      widget.onSelectedFemale("FEMALE");
                      setState(() {
                        widget.selectedFemale = value.toString();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: TypicalText("Other", PRIMARY_COLOR, TEXT_REGULAR),
                    value: "OTHER",
                    groupValue: widget.genderType,
                    onChanged: (value) {
                      widget.onSelectedOther("OTHER");
                      setState(() {
                        widget.selectedOther = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckAgreeToTermAndServiceSectionView extends StatefulWidget {
  Function(bool) isCheckTerms;
  CheckAgreeToTermAndServiceSectionView({required this.isCheckTerms});

  @override
  State<CheckAgreeToTermAndServiceSectionView> createState() =>
      _CheckAgreeToTermAndServiceSectionViewState();
}

class _CheckAgreeToTermAndServiceSectionViewState
    extends State<CheckAgreeToTermAndServiceSectionView> {
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return PRIMARY_COLOR;
    }
    return PRIMARY_COLOR;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(getColor),
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
                widget.isCheckTerms(value);
              });
            },
          ),
          SizedBox(
            width: MARGIN_SMALL,
          ),
          TypicalText("Agree To ", HINT_TEXT_COLOR, TEXT_REGULAR_SMALL),
          TypicalText("Term And Service ", PRIMARY_COLOR, TEXT_REGULAR_SMALL,
              isFontWeight: true),
        ],
      ),
    );
  }
}
