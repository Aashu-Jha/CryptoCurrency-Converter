import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'card_maker.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();

  String selectedCurrency = 'USD';


  @override
  void initState() {
    //calling getCoinData method in initState to get the USD value in initial start screen.
    getCoinData();
    super.initState();
  }

  //HashMap used to store values of all converted currencies.
  Map<String, String> coinValues = {};

  //default value is false. It is used to show at the time of coin_value initialization in CardMaker.
  bool isWaiting = false;
  //This method calls getConvertedCurrency method to request the data through the api in networking.dart class
  void getCoinData() async {

    //set to true at the time of await.
    isWaiting = true;
    try {
      var data = await coinData.getConvertedCurrency(selectedCurrency);
      //set to false instantly after fetching the data.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <CardMaker>[
              CardMaker(text: '1 BTC ', convertedCurrency: isWaiting ? '?': coinValues['BTC'], selectedCurrency: selectedCurrency),
              CardMaker(text: '1 ETH ', convertedCurrency: isWaiting ? '?': coinValues['ETH'], selectedCurrency: selectedCurrency),
              CardMaker(text: '1 LTC ', convertedCurrency: isWaiting ? '?': coinValues['LTC'], selectedCurrency: selectedCurrency),
            ],
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



