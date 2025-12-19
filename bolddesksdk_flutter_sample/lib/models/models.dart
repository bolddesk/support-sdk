class PortfolioModel {
  final double balance;
  final double accountBalance;
  final double buyingPower;
  final double todaysGain;
  final double totalGain;
  final double gainPercentage;

  PortfolioModel({
    required this.balance,
    required this.accountBalance,
    required this.buyingPower,
    required this.todaysGain,
    required this.totalGain,
    required this.gainPercentage,
  });
}

class StockModel {
  final String symbol;
  final String name;
  final double currentPrice;
  final double previousPrice;
  final double changeAmount;
  final double changePercentage;
  final int quantity;
  final List<double> chartData;

  StockModel({
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.previousPrice,
    required this.changeAmount,
    required this.changePercentage,
    required this.quantity,
    required this.chartData,
  });

  bool get isPositive => changeAmount >= 0;
}

class InvestmentModel {
  final String name;
  final String category;
  final double value;
  final double invested;
  final double returnAmount;
  final double returnPercentage;
  final List<double> chartData;

  InvestmentModel({
    required this.name,
    required this.category,
    required this.value,
    required this.invested,
    required this.returnAmount,
    required this.returnPercentage,
    required this.chartData,
  });

  bool get isPositive => returnPercentage >= 0;
}
