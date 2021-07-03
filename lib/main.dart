import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  // const Myapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var confirmed = TextEditingController();
  var recovered = TextEditingController();
  var hospitalized = TextEditingController();
  var deaths = TextEditingController();
  var newConfirmed = TextEditingController();
  var newRecovered = TextEditingController();
  var newHospitalized = TextEditingController();
  var newDeaths = TextEditingController();
  var updateDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    confirmed.text = "-";
    recovered.text = "-";
    hospitalized.text = "-";
    deaths.text = "-";
    newConfirmed.text = "-";
    newRecovered.text = "-";
    newHospitalized.text = "-";
    newDeaths.text = "-";
    updateDate.text = "-";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Covid Checker"),
          actions: [
            IconButton(
                onPressed: () {
                  print("Get Data Covid");
                  getCovidData();
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(height: 20),
            widgetdata("ติดเชื้อสะสม", confirmed.text, Colors.yellow),
            widgetdata("หายป่วย", recovered.text, Colors.green),
            widgetdata(
                "รักษาอยู่ใน รพ.", hospitalized.text, Colors.yellowAccent),
            widgetdata("เสียชีวิต", deaths.text, Colors.red),
            widgetdata("ติดเชื้อเพิ่ม", newConfirmed.text, Colors.redAccent),
            widgetdata("หายป่วยเพิ่ม", newRecovered.text, Colors.greenAccent),
            widgetdata("เข้ารักษาใน รพ.เพิ่ม", newHospitalized.text,
                Colors.yellow[200]),
            widgetdata("เสียชีวิตเพิ่ม", newDeaths.text, Colors.red[200]),
            widgetdata("ข้อมูลล่าสุด", updateDate.text, Colors.blue),
            Center(
              child: Text(
                "Data : https://covid19.th-stat.com/json/covid19v2/getTodayCases.json",
                style: TextStyle(fontSize: 10),
              ),
            ),
              Center(
              child: Text(
                "Credit : UncleEngineer",
                style: TextStyle(fontSize: 10),
              ),
            ),
             Center(
              child: Text(
                "Code : https://github.com/apichaicoding/CovidChecker.git",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ));
  }

  Widget widgetdata(_t1, _t2, _colors) {
    return Column(
      children: [
        Center(
          child: Text(
            _t1,
            style: TextStyle(fontSize: 10),
          ),
        ),
        Center(
          child: Text(
            _t2,
            style: TextStyle(fontSize: 20, color: _colors),
          ),
        )
      ],
    );
  }

  Future getCovidData() async {
    var url =
        Uri.https("covid19.th-stat.com", "/json/covid19v2/getTodayCases.json");
    var response = await http.get(url);
    print("-----------DATA-----------");
    print(response.body);

    var result = json.decode(response.body);
    var v1 = result['Confirmed'];
    var v2 = result['Recovered'];
    var v3 = result['Hospitalized'];
    var v4 = result['Deaths'];
    var v5 = result['NewConfirmed'];
    var v6 = result['NewRecovered'];
    var v7 = result['NewHospitalized'];
    var v8 = result['NewDeaths'];
    var v9 = result['UpdateDate'];

    var formatter = NumberFormat("###,###,###");
    setState(() {
      confirmed.text = formatter.format(v1);
      recovered.text = formatter.format(v2);
      hospitalized.text = formatter.format(v3);
      deaths.text = formatter.format(v4);
      newConfirmed.text = formatter.format(v5);
      newRecovered.text = formatter.format(v6);
      newHospitalized.text = formatter.format(v7);
      newDeaths.text = formatter.format(v8);
      updateDate.text = v9;
    });
  }
}
