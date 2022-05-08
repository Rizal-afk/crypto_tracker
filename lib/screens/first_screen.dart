import 'package:crypto_tracker_2/models/coin.dart';
import 'package:crypto_tracker_2/screens/add_screen.dart';
import 'package:crypto_tracker_2/widgets/designs/coin_card.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  List<Coin> coinList;
  FirstScreen({Key? key, required this.coinList}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                itemCount: coinList.length,
                itemBuilder: (context, index) {
                  // Panggil class penampil koin
                  return SingleChildScrollView(
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddTodoScreen(name: coinList[index].name, imageUrl: coinList[index].imageUrl);
                          }));
                        },
                        child: CoinCard(
                            name: coinList[index].name,
                            symbol: coinList[index].symbol,
                            imageUrl: coinList[index].imageUrl,
                            price: coinList[index].price.toDouble(),
                            change: coinList[index].change.toDouble(),
                            changePercentage:
                              coinList[index].changePercentage.toDouble()),
                  )
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
