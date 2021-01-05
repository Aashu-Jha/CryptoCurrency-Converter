import 'networking.dart';

const apiKey = 'apikey=2BDAF624-2CD0-4722-8ABB-3E899B679D43';
const webUrl = 'https://rest.coinapi.io/v1/exchangerate';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //to get the response in networking.dart through http.getData();
  Future getConvertedCurrency(String requiredCurrency) async {
    NetworkHelper networkHelper = NetworkHelper('$webUrl/BTC/$requiredCurrency?$apiKey');

    var result = await networkHelper.getData();
    return result['rate'];
  }
}
