import 'dart:math';
import 'package:bolddesksdk_flutter_sample/models/periodenum.dart';

class StockSeries {
  final List<double> prices; // ascending time order
  final double currentPrice;
  final double changePct;

  const StockSeries({
    required this.prices,
    required this.currentPrice,
    required this.changePct,
  });
}

class StockCardData {
  final String name;
  final String rate; // e.g., $145.09
  final String percentage; // e.g., +0.5%
  final String stockImage;
  const StockCardData({
    required this.name,
    required this.rate,
    required this.percentage,
    required this.stockImage,
  });
}

class MarketMockData {
  // Companies in the Home grid
  static const List<String> companies = [
    'Vordex Inc.',
    'EchoForge Inc.',
    'PulseNet.com',
    'AstraLogix Inc.',
  ];

  // Internal helper to compute percent change between first and last
  static double _pct(List<double> series) {
    if (series.isEmpty) return 0.0;
    final open = series.first;
    final close = series.last;
    if (open == 0) return 0.0;
    return ((close - open) / open) * 100;
  }

  // For realism, we use smooth synthetic series around a baseline with small drift
  static List<double> _smoothSeries({
    required double start,
    required int points,
    double dailyDriftPct = 0.0,
    double noisePct = 0.15, // 0.15%
  }) {
    final rnd = Random(start.floor());
    final result = <double>[];
    var price = start;
    for (var i = 0; i < points; i++) {
      final drift = price * (dailyDriftPct / 100.0);
      final noise = price * ((rnd.nextDouble() - 0.5) * 2) * (noisePct / 100.0);
      price = (price + drift + noise).clamp(2.0, double.infinity);
      result.add(double.parse(price.toStringAsFixed(2)));
    }
    return result;
  }

  // Time series per company per period
  static final Map<String, Map<Period, StockSeries>> _store = {
    'Vordex Inc.': {
      Period.day: _buildSeries(
        145.10,
        points: 8,
        driftPct: 0.06,
        noisePct: 0.18,
      ),
      Period.week: _buildSeries(
        144.20,
        points: 5,
        driftPct: 0.12,
        noisePct: 0.22,
      ),
      Period.month: _buildSeries(
        139.00,
        points: 22,
        driftPct: 0.08,
        noisePct: 0.20,
      ),
    },
    'EchoForge Inc.': {
      Period.day: _buildSeries(
        92.30,
        points: 8,
        driftPct: -0.02,
        noisePct: 0.22,
      ),
      Period.week: _buildSeries(
        93.10,
        points: 5,
        driftPct: 0.05,
        noisePct: 0.25,
      ),
      Period.month: _buildSeries(
        90.50,
        points: 22,
        driftPct: 0.06,
        noisePct: 0.20,
      ),
    },
    'PulseNet.com': {
      Period.day: _buildSeries(
        58.40,
        points: 8,
        driftPct: 0.03,
        noisePct: 0.30,
      ),
      Period.week: _buildSeries(
        57.90,
        points: 5,
        driftPct: 0.10,
        noisePct: 0.28,
      ),
      Period.month: _buildSeries(
        54.50,
        points: 22,
        driftPct: 0.09,
        noisePct: 0.22,
      ),
    },
    'AstraLogix Inc.': {
      Period.day: _buildSeries(
        208.75,
        points: 8,
        driftPct: -0.03,
        noisePct: 0.16,
      ),
      Period.week: _buildSeries(
        210.10,
        points: 5,
        driftPct: 0.04,
        noisePct: 0.20,
      ),
      Period.month: _buildSeries(
        202.00,
        points: 22,
        driftPct: 0.10,
        noisePct: 0.18,
      ),
    },
  };

  static StockSeries _buildSeries(
    double start, {
    required int points,
    required double driftPct,
    required double noisePct,
  }) {
    final prices = _smoothSeries(
      start: start,
      points: points,
      dailyDriftPct: driftPct,
      noisePct: noisePct,
    );
    final pct = _pct(prices);
    return StockSeries(
      prices: prices,
      currentPrice: prices.last,
      changePct: double.parse(pct.toStringAsFixed(2)),
    );
  }

  static StockSeries seriesFor(String company, Period period) {
    return _store[company]![period]!;
  }

  // Data for Home grid cards
  static List<StockCardData> stockCards(Period period) {
    return companies.map((c) {
      final s = seriesFor(c, period);
      final sign = s.changePct >= 0 ? '+' : '';
      return StockCardData(
        name: c,
        rate: '\$${s.currentPrice.toStringAsFixed(2)}',
        percentage: '$sign${s.changePct.toStringAsFixed(2)}%',
        stockImage: stockImages(period.label, companies.indexOf(c)),
      );
    }).toList();
  }

  static List<String> stockCharts1 = [
    "assets/images/stock1.png",
    "assets/images/stock2.png",
    "assets/images/stock3.png",
    "assets/images/stock4.png",
  ];

  static List<String> stockCharts2 = [
    "assets/images/stock3.png",
    "assets/images/stock2.png",
    "assets/images/stock4.png",
    "assets/images/stock1.png",
  ];

  static List<String> stockCharts3 = [
    "assets/images/stock4.png",
    "assets/images/stock1.png",
    "assets/images/stock3.png",
    "assets/images/stock2.png",
  ];

  static String stockImages(String p, index) {
    switch (p) {
      case "1D":
        return stockCharts1[index];
      case "1W":
        return stockCharts2[index];
      case "1M":
        return stockCharts3[index];
      default:
        return stockCharts1[index];
    }
  }

  // Aggregate for “Today’s Gains” or period headline
  static double totalChangePct(Period period) {
    final list = companies.map((c) => seriesFor(c, period)).toList();
    if (list.isEmpty) return 0;
    final avg =
        list.map((s) => s.changePct).reduce((a, b) => a + b) / list.length;
    return double.parse(avg.toStringAsFixed(2));
  }
}
