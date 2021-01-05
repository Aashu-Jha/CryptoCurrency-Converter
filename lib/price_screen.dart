import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';
  String convertedCurrency = '?';

  @override
  void initState() {
    //calling getCoinData method in initState to get the USD value in initial start screen.
    getCoinData();
    super.initState();
  }

  //This method calls getConvertedCurrency method to request the data through the api in networking.dart class
  void getCoinData() async {
    num temp = await coinData.getConvertedCurrency(selectedCurrency);
    setState(() {
      convertedCurrency = temp.toStringAsFixed(0);
    });
  }

  //Dropdown button in bottom screen to show in Android Platform.
  // It will the show list of currencies in which we can get the values.
  DropdownButton getDropdownButton() {
    //blank list to add the currencies.
    List<DropdownMenuItem<String>> dropDownItemList = [];
     for(String item in currenciesList) {
       var addItem = DropdownMenuItem(child: Text(item), value: item,);
       dropDownItemList.add(addItem);
     }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItemList,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          convertedCurrency= '?';
          getCoinData();
        });
      },
    );
  }

  //CupertinoPicker to show the list of currencies in which we can convert the coins.
  // If the platform is IOS, then we will call it.
  CupertinoPicker getPicker() {
    List<Text> pickerItemsList  = [];
    for(String item in currenciesList) {
      pickerItemsList.add(Text(item));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex){
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          convertedCurrency = '?';
          getCoinData();
        });
      },
      children: pickerItemsList,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $convertedCurrency $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getPicker() : getDropdownButton(),
          ),
        ],
      ),
    );
  }


}


