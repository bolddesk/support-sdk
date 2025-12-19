import 'package:bolddesksdk_flutter_sample/models/periodenum.dart';


class InvestmentHeadline {
  final String headlineChangeText; // e.g., "1.2% Today"
  final double totalValue;         // e.g., 10000
  final double changeAbsolute;     // e.g., 200
  final double changePct;          // e.g., 2.0
  const InvestmentHeadline({
    required this.headlineChangeText,
    required this.totalValue,
    required this.changeAbsolute,
    required this.changePct,
  });
}

class PositionItem {
  final String symbol;
  final String sharesText; // "50 shares"
  const PositionItem({required this.symbol, required this.sharesText});
}

class InvestmentStats {
  final double totalGain;
  final double totalLoss;
  final double netGain;
  final String bestPerformer;
  final String worstPerformer;
  final double avgGainPct;
  final double avgLossPct;
  final int totalVolume;
  final String highestVolumeSymbol;
  final String lowestVolumeSymbol;

  const InvestmentStats({
    required this.totalGain,
    required this.totalLoss,
    required this.netGain,
    required this.bestPerformer,
    required this.worstPerformer,
    required this.avgGainPct,
    required this.avgLossPct,
    required this.totalVolume,
    required this.highestVolumeSymbol,
    required this.lowestVolumeSymbol,
  });
}

class InvestmentMockData {
  // Period-based headline
  static InvestmentHeadline headline(Period period) {
    switch (period) {
      case Period.day:
        return InvestmentHeadline(
          headlineChangeText: '1.2% Today',
          totalValue: 10000,
          changeAbsolute: 120,
          changePct: 1.2,
        );
      case Period.week:
        return InvestmentHeadline(
          headlineChangeText: '3.8% This Week',
          totalValue: 10150,
          changeAbsolute: 380,
          changePct: 3.8,
        );
      case Period.month:
        return InvestmentHeadline(
          headlineChangeText: '8.4% This Month',
          totalValue: 10840,
          changeAbsolute: 840,
          changePct: 8.4,
        );
    }
  }

  // Same symbols as shown on page
  static List<PositionItem> positions(Period period) {
    switch (period) {
      case Period.day:
        return const [
          PositionItem(symbol: 'VTBX', sharesText: '50 shares'),
          PositionItem(symbol: 'EFRG', sharesText: '10 shares'),
          PositionItem(symbol: 'PNSY', sharesText: '5 shares'),
          PositionItem(symbol: 'ALGX', sharesText: '20 shares'),
        ];
      case Period.week:
        return const [
          PositionItem(symbol: 'VTBX', sharesText: '48 shares'),
          PositionItem(symbol: 'EFRG', sharesText: '11 shares'),
          PositionItem(symbol: 'PNSY', sharesText: '6 shares'),
          PositionItem(symbol: 'ALGX', sharesText: '20 shares'),
        ];
      case Period.month:
        return const [
          PositionItem(symbol: 'VTBX', sharesText: '52 shares'),
          PositionItem(symbol: 'EFRG', sharesText: '12 shares'),
          PositionItem(symbol: 'PNSY', sharesText: '5 shares'),
          PositionItem(symbol: 'ALGX', sharesText: '19 shares'),
        ];
    }
  }

  // Stats section
  static InvestmentStats stats(Period period) {
    switch (period) {
      case Period.day:
        return const InvestmentStats(
          totalGain: 500,
          totalLoss: 100,
          netGain: 400,
          bestPerformer: 'PNSY',
          worstPerformer: 'VTBX',
          avgGainPct: 1.5,
          avgLossPct: 0.5,
          totalVolume: 300,
          highestVolumeSymbol: 'PNSY',
          lowestVolumeSymbol: 'EFRG',
        );
      case Period.week:
        return const InvestmentStats(
          totalGain: 1240,
          totalLoss: 410,
          netGain: 830,
          bestPerformer: 'EFRG',
          worstPerformer: 'VTBX',
          avgGainPct: 3.2,
          avgLossPct: 1.1,
          totalVolume: 1820,
          highestVolumeSymbol: 'EFRG',
          lowestVolumeSymbol: 'PNSY',
        );
      case Period.month:
        return const InvestmentStats(
          totalGain: 3510,
          totalLoss: 980,
          netGain: 2530,
          bestPerformer: 'VTBX',
          worstPerformer: 'ALGX',
          avgGainPct: 5.0,
          avgLossPct: 1.4,
          totalVolume: 7120,
          highestVolumeSymbol: 'VTBX',
          lowestVolumeSymbol: 'PNSY',
        );
    }
  }

  // Specific stock short headline
  static String specificStockHeadline(Period period) {
    switch (period) {
      case Period.day:
        return '0.8% Today';
      case Period.week:
        return '2.6% This Week';
      case Period.month:
        return '6.1% This Month';
    }
  }

  // “Today’s Volume” widget number fallback
  static String volumeHeadline(Period period) {
    switch (period) {
      case Period.day:
        return '500,000';
      case Period.week:
        return '2,450,000';
      case Period.month:
        return '9,800,000';
    }
  }
}