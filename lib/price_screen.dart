import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

const apiKey = '97586C47-214E-4083-85B7-AD60A38C1464';
const apiCoinUrl = 'https://rest.coinapi.io/v1/exchangerate/';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = 'USD';
  String? selectedFromCurrency = 'BTC';
  double? rateValueBTC, rateValueETH, rateValueLTC;
  var recievedDataBTC, recievedDataETH, recievedDataLTC;
  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  Future<dynamic>? getData() async {
    CoinData coinDataBTC =
        CoinData('$apiCoinUrl' 'BTC' '/' '$selectedCurrency?apikey=$apiKey');
    CoinData coinDataETH =
        CoinData('$apiCoinUrl' 'ETH' '/' '$selectedCurrency?apikey=$apiKey');
    CoinData coinDataLTC =
        CoinData('$apiCoinUrl' 'LTC' '/' '$selectedCurrency?apikey=$apiKey');
    recievedDataBTC = await coinDataBTC.getData();
    recievedDataETH = await coinDataETH.getData();
    recievedDataLTC = await coinDataLTC.getData();
    setState(() {
      selectedCurrency = recievedDataBTC['asset_id_quote'];
      rateValueBTC = recievedDataBTC['rate'];
      rateValueETH = recievedDataETH['rate'];
      rateValueLTC = recievedDataLTC['rate'];
    });
  }
//make get data & updateUi in same function getData

  // void updateUI(dynamic recievedData) {
  //   setState(() {
  //     selectedFromCurrency = recievedData['asset_id_base'];
  //     selectedCurrency = recievedData['asset_id_quote'];
  //     rateValue = recievedData['rate'];
  //   });
  // }

  @override
  void initState() {
    super.initState();
    getData(); // Call getData() when the screen loads up
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
                  '1 BTC = $rateValueBTC $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 ETH = $rateValueETH $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
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
                  '1 LTC = $rateValueLTC $selectedCurrency',
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
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
