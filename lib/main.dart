import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          fontFamily: 'Poppins',
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintStyle: TextStyle(fontSize: 24, color: Colors.white30),
          )),
      home: MainScreenApp(),
    ));

const PC = Color.fromRGBO(255, 161, 223, 1);
const WC = Colors.white;
const PA = Color.fromRGBO(255, 107, 231, 1);
const B = Color.fromRGBO(0, 75, 157, 1);
const GC = Color.fromRGBO(158, 0, 133, 1);
const TC = Color.fromRGBO(99, 0, 71, 1);
const PC2 = Color.fromRGBO(241, 0, 159, 1);
ct(double top) => Container(margin: EdgeInsets.only(top: top));
const g = [
  "oxoxoxxoxoxoxxxoxxoxoxoxoxxo",
  "xoxoxxoxoxoxoooxoxxoxoxoxoxx",
  "oxooxoxxxoxooxxxxoxxoxoxoxox",
  "xoxooxxooxoooooxoxoxxxxoxoxo",
  "xoxoxxoooooxooooooxoxxoxoxxo",
  "xxxoooxxxooxoooooooxooxoxoxo",
  "xxxooxxooxxxooooooooxoxxoxox",
  "xxxoxooxxxxxoooxoxoxoxoxxoxo",
  "xxxooxoxoxxxooooooxoxoxoxxox",
  "xxoooxoxoxxoooooooxxoxoxoxxo",
  "xoxooxoxooooxoooxxxoxoxoxxox",
  "xoxooooxoxooxxxxxxxxoooxoxox"
];

class MainScreenApp extends StatefulWidget {
  _MainScreenAppState createState() => _MainScreenAppState();
}

class _MainScreenAppState extends State<MainScreenApp> {
  DateTime selectedDate;
  int comAge;
  bool isBoy = false;
  bool inl = true;
  build(context) => Scaffold(body: _background());

  _appName() => Text("Baby Predictor",
      style: TextStyle(color: WC, fontSize: 36, fontWeight: FontWeight.bold));

  _textField(hint) => TextField(
      style: TextStyle(color: WC, fontSize: 24),
      keyboardType: TextInputType.number,
      onChanged: (val) {
        setState(() {
          comAge = int.parse(val);
        });
      },
      decoration: InputDecoration(hintText: hint));

  _dateButton(hint, {n = false}) {
    bool sel = selectedDate == null;
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            sel ? hint : selectedDate.toIso8601String().substring(0, 10),
            style: TextStyle(fontSize: 24, color: sel ? Colors.white30 : WC),
          )),
    );
  }

  _goButton() {
    return Container(
      width: 345,
      height: 65,
      child: RaisedButton(
        onPressed: () {
          _operation();
        },
        color: WC,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(300.0)),
        elevation: 10,
        child: Text(
          "GO",
          style: TextStyle(color: PC2, fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _resultCard() {
    if (!inl)
      return Card(
        color: WC,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 10,
        child: Container(
          width: 345,
          height: 280,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _babyText(),
              ct(20),
              SvgPicture.asset("assets/baby${isBoy ? '' : "-girl"}.svg"),
              ct(20),
              _getGender(),
            ],
          ),
        ),
      );
    return Container();
  }

  _babyText() => Text("Your baby is most likely to be",
      style: TextStyle(color: TC, fontSize: 18));

  _getGender() => Text(isBoy ? "BOY" : "GIRL",
      style: TextStyle(fontSize: 24, color: isBoy ? B : PA));

  _background() => Container(
      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [PC, PC2],
      )),
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ct(10),
          _appName(),
          ct(20),
          _textField("Completed Age"),
          _dateButton("Last Menses Date (LMP)"),
          ct(30),
          _goButton(),
          ct(30),
          _resultCard()
        ],
      )));

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  _operation() {
    final m = selectedDate.add(Duration(days: 16)).month;
    setState(() {
      isBoy = g[m - 1][comAge - 18] == 'x';
      inl = false;
    });
  }
}
