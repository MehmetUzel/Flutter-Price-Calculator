import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profcalculator/presentation/profit_calculator_icon_icons.dart';
import 'package:profcalculator/util/hexcolor.dart';

//author : Mehmet Uzel

class ProfitCalculator extends StatefulWidget {
  @override
  _ProfitCalculatorState createState() => _ProfitCalculatorState();
}

class _ProfitCalculatorState extends State<ProfitCalculator> {
  int _comissionPercentage = 0;
  double _buyingPrice = 0;
  int _desiredProfitPercentage = 0;
  double _sellingPrice = 0;
  double _shipmentPrice = 0;

  Color _orange = HexColor("#F98404");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
        alignment: Alignment.center,
        color: Colors.transparent,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 115,
              decoration: BoxDecoration(
                  color: _orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(13.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Satış Fiyatı",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: _orange),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${calculateSellingPrice(_buyingPrice, _desiredProfitPercentage, _comissionPercentage, _shipmentPrice)} ₺",
                        style: TextStyle(
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                            color: _orange),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    style: TextStyle(
                      color: _orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        labelText: "Alış Fiyatı : ",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: _orange),
                        prefixIcon: Icon(
                            ProfitCalculatorIcon.turkish_lira_symbol_black)),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          _buyingPrice = double.parse(value);
                        });
                      } catch (exception) {
                        setState(() {
                          _buyingPrice = 0.0;
                        });
                      }
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    style: TextStyle(
                      color: _orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                        labelText: "Komisyon Yüzdesi : %",
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                            color: _orange),
                        prefixIcon: Icon(Icons.waterfall_chart)),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          _comissionPercentage = int.parse(value);
                        });
                      } catch (exception) {
                        setState(() {
                          _comissionPercentage = 0;
                        });
                      }
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    style: TextStyle(
                      color: _orange,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      labelText: "Kargo Ücreti : ",
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.0,
                          color: _orange),
                      prefixIcon: Icon(Icons.local_shipping),
                    ),
                    onChanged: (String value) {
                      try {
                        setState(() {
                          _shipmentPrice = double.parse(value);
                        });
                      } catch (exception) {
                        setState(() {
                          _shipmentPrice = 0.0;
                        });
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Alış Fiyatı Üzerinden Beklenen Kar Yüzdesi", style: TextStyle(
                        color: Colors.grey.shade700,

                      ),),
                      Padding(padding: const EdgeInsets.only(top: 58.0))
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "$_desiredProfitPercentage%",
                        style: TextStyle(
                            color: _orange,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _orange,
                          inactiveColor: Colors.grey,
                          divisions: 20,
                          value: _desiredProfitPercentage.toDouble(),
                          onChanged: (double value) {
                            setState(() {
                              _desiredProfitPercentage = value.round();
                            });
                          })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateSellingPrice(double buyingPrice, int profitPercentage, int commissionPercentage, double shipmentPrice){
    return (((buyingPrice*((100+profitPercentage)/100))+shipmentPrice)/ ((100 - _comissionPercentage) / 100)).toStringAsFixed(2);
  }
}
