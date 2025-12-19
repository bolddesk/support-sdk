import 'package:bolddesksdk_flutter_sample/constants/colors.dart';
import 'package:bolddesksdk_flutter_sample/constants/styles.dart';
import 'package:bolddesksdk_flutter_sample/data/investment_mock_data.dart';
import 'package:bolddesksdk_flutter_sample/models/periodenum.dart';
import 'package:bolddesksdk_flutter_sample/widgets/period_selector.dart';
import 'package:flutter/material.dart';

class InvestmentScreen extends StatefulWidget {
  const InvestmentScreen({super.key});

  @override
  State<InvestmentScreen> createState() => _InvestmentScreenState();
}

class _InvestmentScreenState extends State<InvestmentScreen> {
  String firstPeriod = "1D";
  String secondPeriod = "1D";

  Period get _firstPeriodEnum => parsePeriod(firstPeriod);
  Period get _secondPeriodEnum => parsePeriod(secondPeriod);

  final helpItems = [
    {"label": "Trade Policy", "icon": "assets/images/Globe.png"},
    {"label": "Payment Policy", "icon": "assets/images/Coins.png"},
    {"label": "Account Policy", "icon": "assets/images/User.png"},
  ];

  String _chartAssetForFirstPeriod(String p) {
    switch (p) {
      case "1D":
        return "assets/images/1M.png";
      case "1W":
        return "assets/images/1D.png";
      case "1M":
        return "assets/images/1W.png";
      default:
        return "assets/images/1D.png";
    }
  }

  String _chartAssetForSecondPeriod(String p) {
    switch (p) {
      case "1D":
        return "assets/images/1W.png";
      case "1W":
        return "assets/images/1M.png";
      case "1M":
        return "assets/images/1D.png";
      default:
        return "assets/images/1D.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final head = InvestmentMockData.headline(_firstPeriodEnum);
    final pos = InvestmentMockData.positions(_secondPeriodEnum);
    final stats = InvestmentMockData.stats(_secondPeriodEnum);
    final headSecond = InvestmentMockData.headline(_secondPeriodEnum);
    final specificHeadline = InvestmentMockData.specificStockHeadline(
      _secondPeriodEnum,
    );
    final volumeText = InvestmentMockData.volumeHeadline(_secondPeriodEnum);

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: AppColors.darkText,
          ),
        ),
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightBg,
        title: Text("Investment", style: AppStyles.heading3),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Gain Indicator
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/BarChart.png',
                      width: 18,
                      height: 18,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      head.headlineChangeText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Period Selector
              PeriodSelector(
                period: firstPeriod,
                onChanged: (p) => setState(() => firstPeriod = p),
              ),

              // Large Chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  _chartAssetForFirstPeriod(firstPeriod),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),

              // Specific Stock Gain
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Specific Stock",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Layers.png',
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          specificHeadline,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Second Chart
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Image.asset(
                  _chartAssetForSecondPeriod(secondPeriod),
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              PeriodSelector(
                period: secondPeriod,
                onChanged: (p) => setState(() => secondPeriod = p),
              ),
              const SizedBox(height: 16),
              // Your Position
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Position",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Position Grid
                    GridView(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                      ),
                      children: [
                        // build from `pos` list returned by InvestmentMockData.positions(_secondPeriodEnum)
                        for (var i = 0; i < pos.length; i++)
                          _positionItem(
                            pos[i].symbol,
                            pos[i].sharesText,
                            width,
                            leftPadding: i % 2 == 1 ? 16 : 0,
                          ),
                      ],
                    ),

                    const SizedBox(height: 6),
                    _totalRow(
                      "Total Value",
                      "\$${headSecond.totalValue.toStringAsFixed(0)}",
                      "${headSecond.changePct >= 0 ? '+' : ''}${headSecond.changePct.toStringAsFixed(1)}%",
                    ),
                    const Divider(),
                    _totalRow(
                      // Show absolute for the same second period
                      _secondPeriodEnum == Period.day
                          ? "Change Today"
                          : _secondPeriodEnum == Period.week
                          ? "Change This Week"
                          : "Change This Month",
                      "\$${headSecond.changeAbsolute.toStringAsFixed(0)}",
                      "${headSecond.changePct >= 0 ? '+' : ''}${headSecond.changePct.toStringAsFixed(1)}%",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Investment Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text(
                  "Investment Stats",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF111827),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4,
                  ),
                  children: [
                    _statItem(
                      "Total Gain",
                      "\$${stats.totalGain.toStringAsFixed(0)}",
                      width,
                    ),
                    _statItem(
                      "Total Loss",
                      "\$${stats.totalLoss.toStringAsFixed(0)}",
                      width,
                    ),
                    _statItem(
                      "Net Gain",
                      "\$${stats.netGain.toStringAsFixed(0)}",
                      width,
                    ),
                    _statItem("Best Performer", stats.bestPerformer, width),
                    _statItem("Worst Performer", stats.worstPerformer, width),
                    _statItem(
                      "Average Gain",
                      "${stats.avgGainPct.toStringAsFixed(1)}%",
                      width,
                    ),
                    _statItem(
                      "Average Loss",
                      "${stats.avgLossPct.toStringAsFixed(1)}%",
                      width,
                    ),
                    _statItem("Total Volume", "${stats.totalVolume}", width),
                    _statItem(
                      "Highest Volume",
                      stats.highestVolumeSymbol,
                      width,
                    ),
                    _statItem("Lowest Volume", stats.lowestVolumeSymbol, width),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Today's Volume
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _secondPeriodEnum == Period.day
                                ? "Today's Volume"
                                : _secondPeriodEnum == Period.week
                                ? "This Week's Volume"
                                : "This Month's Volume",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF667085),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            volumeText,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7C3AED),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Trade Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Help Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Need More Help?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: AppColors.lightBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFEAECF0)),
                      ),
                      child: Column(
                        children: helpItems.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          return Column(
                            children: [
                              ListTile(
                                minVerticalPadding: 0,
                                leading: Image.asset(
                                  item['icon']!,
                                  width: 18,
                                  height: 18,
                                ),
                                title: Text(
                                  item['label']!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF475467),
                                  ),
                                ),
                                trailing: Image.asset(
                                  'assets/images/Forward.png',
                                  width: 16,
                                  height: 16,
                                ),
                                // contentPadding: const EdgeInsets.symmetric(
                                //   horizontal: 6,
                                //   vertical: 6,
                                // ),
                                onTap: () {},
                              ),
                              if (index != helpItems.length - 1)
                                const Divider(
                                  height: 1,
                                  color: Color(0xFFEAECF0),
                                ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _positionItem(
    String label,
    String value,
    double width, {
    double leftPadding = 0,
  }) {
    return Container(
      width: width / 2,
      padding: EdgeInsets.only(left: leftPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF667085),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF111827),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalRow(String label, String value, String gain) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: Color(0xFF667085)),
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                gain,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF667085),
                ),
              ),
            ],
          ),
          SizedBox(width: 50),
        ],
      ),
    );
  }

  Widget _statItem(String label, String value, double width) {
    return Container(
      width: width / 2 - 16,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF667085),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    value,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF344054),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Container(height: 1, color: const Color(0xFFE5E7EB)),
        ],
      ),
    );
  }
}
