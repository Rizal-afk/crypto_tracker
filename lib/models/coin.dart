// Class untuk menangkap data koin
class Coin {
  String name;
  String symbol;
  String imageUrl;
  num price;
  num change;
  num changePercentage;

  Coin({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        name: json['name'] == null ? "" : json['name'],
        symbol: json['symbol'] == null ? "" : json['symbol'],
        imageUrl: json['image'] == null ? "" : json['image'],
        price: json['current_price'] == null ? 0 : json['current_price'],
        change: json['price_change_24h'] == null ? 0 : json['price_change_24h'],
        changePercentage: json['price_change_percentage_24h'] == null
            ? 0
            : json['price_change_percentage_24h']);
  }
}

List<Coin> coinList = [];
