import 'dart:async';
import 'dart:convert';

import 'package:crypto_tracker_2/models/coin.dart';
import 'package:crypto_tracker_2/screens/first_screen.dart';
import 'package:crypto_tracker_2/screens/second_screen.dart';
import 'package:crypto_tracker_2/screens/third_screen.dart';
import 'package:crypto_tracker_2/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final String imagePath;
  final String name;
  final String email;
  const HomeScreen({
    Key? key,
    this.imagePath = "",
    this.name = "",
    this.email = "",
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late final List<Widget> _screenList = [
    FirstScreen(coinList: coinList), // render screen pertama
    SecondScreen(), // render screen kedua
    ThirdScreen(imagePath: widget.imagePath, name: widget.name, email: widget.email,) // render screen ketiga
    // Setiap screen sudah auto ditampilkan, jadi nanti tinggal buat class barunya aja.
  ];



  // Fetch api untuk mendapat data coin
  Future<List<Coin>> fetchCoins() async {
    coinList = [];
    final response = await http.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=1h'));

    if (response.statusCode == 200) {
      List<dynamic> values = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (var i = 0; i < values.length; i++) {
          if (values[i] != null) {
            Map<String, dynamic> map = values[i];
            coinList.add(Coin.fromJson(map));
          }
        }
        setState(() {
          coinList;
        });
      }
      return coinList;
    } else {
      throw Exception('Failed to fetch');
    }
  }

  // Initial state untuk pemanggilang fetch api
  @override
  void initState() {
    fetchCoins();
    Timer.periodic(const Duration(seconds: 10), ((timer) => fetchCoins()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 12, 54, 1),
      bottomNavigationBar: Navbar(
          onPressed: (i) {
            setState(() {
              _selectedIndex = i;
            });
          },
          selectedIndex: _selectedIndex),
      body: _screenList[_selectedIndex], // List screen diatas dipanggil disini
    );
  }
}
