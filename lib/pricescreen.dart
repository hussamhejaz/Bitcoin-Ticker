import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';

import 'dart:io' show Platform;

class PricePage extends StatefulWidget {
  const PricePage({super.key});

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  String selectCurrentCurrency = currenciesList.first;





  DropdownButton<String> getDropDwown() {
    List<DropdownMenuItem<String>> dropdown = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdown.add(newItem);

    }

    return DropdownButton<String>(
      value: selectCurrentCurrency,
      onChanged: (value) {
        setState(() {
          selectCurrentCurrency = value!;
          getData();
        });
      },
      items: dropdown,
    );

  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectIndex) {
      setState(() {
        selectCurrentCurrency = currenciesList[selectIndex];
        getData();
      });

        },
        children: pickerItems);

  }

  Map<String, String> coinValues = {};
  //7: Figure out a way of displaying a '?' on screen while we're waiting for the price data to come back. First we have to create a variable to keep track of when we're waiting on the request to complete.
  bool isWaiting = false;

  void getData() async {
    //7: Second, we set it to true when we initiate the request for prices.
    isWaiting = true;
    try {
      //6: Update this method to receive a Map containing the crypto:price key value pairs.
      var data = await CoinData().getCoinData(selectCurrentCurrency);
      //7. Third, as soon the above line of code completes, we now have the data and no longer need to wait. So we can set isWaiting to false.
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
            child: Text(
          'Bitcoin Ticker',
          style: TextStyle(color: Colors.white, fontSize: 20),
        )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ReusableCard( cryptoCurrency: 'BTC',
            //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
            value:  coinValues['BTC'],
            selectedCurrency: selectCurrentCurrency,),
          ReusableCard( cryptoCurrency: 'ETH',
            //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
            value:  coinValues['ETH'],
            selectedCurrency: selectCurrentCurrency,),
          ReusableCard( cryptoCurrency: 'LTC',
            //7. Finally, we use a ternary operator to check if we are waiting and if so, we'll display a '?' otherwise we'll show the actual price data.
            value:  coinValues['LTC'],
            selectedCurrency: selectCurrentCurrency,),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isIOS? iosPicker() : getDropDwown(),
          ),
        ],
      ),
    );
  }
}

class ReusableCard extends StatelessWidget {
  const ReusableCard({
    super.key,
    required this.value,  required this.selectedCurrency , required this.cryptoCurrency
  });

  final dynamic value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child:  Padding(
          padding:const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency =${value! ?? '?'} $selectedCurrency',
            textAlign: TextAlign.center,
            style:const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
