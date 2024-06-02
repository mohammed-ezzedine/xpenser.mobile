class Currency {
  final String code;
  final String symbol;
  final String name;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    print("currency " + json.toString());
    return switch(json) {
      {
      'code': String code,
      'symbol': String symbol,
      'name': String name
      } => Currency(code: code, symbol: symbol, name: name),
      _ => throw const FormatException('Failed to load currency')
    };
  }
}