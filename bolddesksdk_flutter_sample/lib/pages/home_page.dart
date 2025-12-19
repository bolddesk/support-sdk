import 'package:bd_support_sdk/bolddesk_support_sdk.dart';
import 'package:bolddesksdk_flutter_sample/data/market_data.dart';
import 'package:bolddesksdk_flutter_sample/models/periodenum.dart';
import 'package:bolddesksdk_flutter_sample/widgets/period_selector.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../widgets/portfolio_header.dart';
import '../widgets/stock_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // inside _HomePageState
  String selectedPeriod = "1D";

  Period get _periodEnum => parsePeriod(selectedPeriod);
  void _onItemTapped(int index) {
    // Navigate to different pages based on index
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        BoldDeskSupportSDK.showHome();
        break;
      case 3:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    initializeSDK();
  }

  String generateJwt({required String secretKey, required String email}) {
    // iat in seconds since epoch (UTC)
    final issuedAt = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;

    final jwt = JWT({'email': email, 'name': "", 'iat': issuedAt});

    // Sign with HS256
    final token = jwt.sign(SecretKey(secretKey), algorithm: JWTAlgorithm.HS256);

    return token;
  }

  Future<void> initializeSDK() async {
    await BoldDeskSupportSDK.initialize(
      "YOUR_APP_ID",
      "YOUR_BRAND_URL",
      onSuccess: (_) async {
        var isUserLoggedIn = await BoldDeskSupportSDK.isLoggedIn();
        if (!isUserLoggedIn) {
          final secretkey = "YOUR_SECRET_KEY";
          final email = "YOUR_MAIL_ID";
          final jwtToken = generateJwt(secretKey: secretkey, email: email);
          await BoldDeskSupportSDK.loginWithJWTToken(jwtToken);
        }
      },
      onError: (error) {},
    );
  }

  String _chartAssetForPeriod(String p) {
    switch (p) {
      case "1D":
        return "assets/images/1D.png";
      case "1W":
        return "assets/images/1W.png";
      case "1M":
        return "assets/images/1M.png";
      default:
        return "assets/images/1D.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    // Build data for current period
    final cards = MarketMockData.stockCards(_periodEnum);
    final todayChange = MarketMockData.totalChangePct(_periodEnum);
    final todaySign = todayChange >= 0 ? '↑' : '↓';
    final todayColor = todayChange >= 0
        ? AppColors.positive
        : AppColors.negative;
    final headlineSuffix = _periodEnum == Period.day
        ? 'Today'
        : _periodEnum == Period.week
        ? 'This Week'
        : 'This Month';

    return Scaffold(
      backgroundColor: AppColors.lightBg,
      appBar: AppBar(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightBg,
        title: Text("Finance Management", style: AppStyles.heading3),
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountBalanceCard(),
              const SizedBox(height: 24),
              FeaturesGrid(
                items: [
                  FeatureItem(
                    icon: "assets/images/SavingsIcon.png",
                    title: 'Savings',
                    subtitle: 'Earn 2% APY',
                  ),
                  FeatureItem(
                    icon: "assets/images/InvestIcon.png",

                    title: 'Invest',
                    subtitle: 'Stocks & Bonds',
                  ),
                  FeatureItem(
                    icon: "assets/images/BitCoinIcon.png",
                    title: 'Buy Bitcoin',
                    subtitle: 'Secure Platform',
                  ),
                  FeatureItem(
                    icon: "assets/images/TaxFillingIcon.png",
                    title: 'Tax Filing',
                    subtitle: 'Maximize Refund',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  '$headlineSuffix\'s Gains',
                  style: AppStyles.heading2.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text:
                            '$todaySign ${todayChange.abs().toStringAsFixed(2)}% ',
                        style: AppStyles.heading3.copyWith(color: todayColor),
                      ),
                      TextSpan(
                        text: headlineSuffix,
                        style: AppStyles.heading3.copyWith(
                          color: isDark
                              ? AppColors.lightText
                              : AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              PeriodSelector(
                period: selectedPeriod,
                optionalHorizontalPadding: 8,
                onChanged: (p) => setState(() => selectedPeriod = p),
              ),
              const SizedBox(height: 18),
              Image.asset(_chartAssetForPeriod(selectedPeriod)),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Stocks",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Performance",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              StockGrid(
                items: cards.map((c) {
                  return StockItem(
                    stockName: c.name,
                    stockRate: c.rate,
                    stockPercentage: c.percentage,
                    stockImage: c.stockImage,
                  );
                }).toList(),
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            currentIndex: 0,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: isDark
                ? AppColors.lightText
                : AppColors.darkText,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/Chat.png",
                  width: 22,
                  height: 22,
                ),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/Help.png",
                  width: 22,
                  height: 22,
                ),
                label: 'Help',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
