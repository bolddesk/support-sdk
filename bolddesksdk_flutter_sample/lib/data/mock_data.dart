import 'package:bolddesksdk_flutter_sample/models/models.dart';
import 'dart:ui'; // Import for Color

class MockData {
  // Portfolio Data
  static PortfolioModel getPortfolioData() {
    return PortfolioModel(
      balance: 12345.67,
      accountBalance: 8945.32,
      buyingPower: 3400.35,
      todaysGain: 245.67,
      totalGain: 2345.67,
      gainPercentage: 15.5,
    );
  }

  // Investment Data
  static List<InvestmentModel> getInvestments() {
    return [
      InvestmentModel(
        name: 'Tech Fund',
        category: 'Technology',
        value: 5234.56,
        invested: 4500.00,
        returnAmount: 734.56,
        returnPercentage: 16.32,
        chartData: [4500.0, 4650.2, 4820.5, 5012.3, 5123.4, 5234.56],
      ),
      InvestmentModel(
        name: 'Growth Portfolio',
        category: 'Mixed',
        value: 8945.23,
        invested: 7800.00,
        returnAmount: 1145.23,
        returnPercentage: 14.68,
        chartData: [7800.0, 8012.3, 8234.5, 8567.2, 8756.8, 8945.23],
      ),
      InvestmentModel(
        name: 'Index Fund',
        category: 'Index',
        value: 3456.78,
        invested: 3200.00,
        returnAmount: 256.78,
        returnPercentage: 8.02,
        chartData: [3200.0, 3256.3, 3312.5, 3367.8, 3412.3, 3456.78],
      ),
      InvestmentModel(
        name: 'Dividend Stock',
        category: 'Dividend',
        value: 2123.45,
        invested: 2000.00,
        returnAmount: 123.45,
        returnPercentage: 6.17,
        chartData: [2000.0, 2031.2, 2062.5, 2090.3, 2105.8, 2123.45],
      ),
    ];
  }

  // FAQ Data
  static List<Map<String, String>> getFaqData() {
    return [
      {
        'question': 'How do I start investing?',
        'answer':
            'You can start investing by opening an account, verifying your identity, and making your first deposit. Then choose stocks or funds and place your first order.',
      },
      {
        'question': 'What are the fees?',
        'answer':
            'We offer zero commission trading on stocks and ETFs. Some funds may have annual management fees ranging from 0.1% to 0.5%.',
      },
      {
        'question': 'Is my money safe?',
        'answer':
            'Yes, your investments are protected by industry-standard security measures and are FDIC insured up to \$250,000.',
      },
      {
        'question': 'Can I withdraw my money anytime?',
        'answer':
            'Yes, you can withdraw your money anytime. Withdrawals typically take 1-2 business days to process.',
      },
      {
        'question': 'What is the minimum investment?',
        'answer':
            'There is no minimum investment required to get started. You can start with any amount.',
      },
    ];
  }

  // Settings Options
  static List<Map<String, String>> getSettingsOptions() {
    return [
      {'title': 'Dark Theme', 'icon': 'theme'},
      {'title': 'Notifications', 'icon': 'notifications'},
      {'title': 'Security', 'icon': 'security'},
      {'title': 'Privacy', 'icon': 'privacy'},
      {'title': 'About', 'icon': 'about'},
    ];
  }

  // More Options
  static List<Map<String, String>> getMoreOptions() {
    return [
      {
        'title': 'Referral Program',
        'subtitle': 'Earn rewards',
        'icon': 'referral',
      },
      {
        'title': 'Education',
        'subtitle': 'Learn investing',
        'icon': 'education',
      },
      {
        'title': 'Community',
        'subtitle': 'Connect & share',
        'icon': 'community',
      },
      {
        'title': 'Send Feedback',
        'subtitle': 'Help us improve',
        'icon': 'feedback',
      },
    ];
  }

  // Profile Data
  static Map<String, dynamic> getProfileData() {
    return {
      'name': 'Olivia Rhye',
      'upiId': 'UPI ID: Olivi-y001-T30Uhdfcbank',
      'upiNumber': 'UPI Number',
      'rewards': 7,
      'rewardAmount': 70,
      'avatarUrl': 'https://via.placeholder.com/60',
      'paymentMethods': [
        {'title': 'Bank Account', 'subtitle': '2 accounts', 'icon': 'bank'},
        {'title': 'Credit Card', 'subtitle': 'Pay with UPI', 'icon': 'card'},
        {'title': 'UPI Link', 'subtitle': 'Pay UPI-Free', 'icon': 'upi'},
      ],
      'menuItems': [
        {'title': 'Get Help', 'icon': 'help', 'hasNotification': false},
        {'title': 'Contact us', 'icon': 'contact', 'hasNotification': false},
        {
          'title': 'Pay with credit or debit cards',
          'icon': 'creditcard',
          'hasNotification': false,
        },
        {'title': 'Your QR code', 'icon': 'qr', 'hasNotification': false},
        {
          'title': 'Transaction History',
          'icon': 'history',
          'hasNotification': false,
        },
        {'title': 'Settings', 'icon': 'settings', 'hasNotification': false},
      ],
    };
  }

  // Settings Theme Colors
  static List<Map<String, dynamic>> getThemeColors() {
    return [
      {'color': Color(0xFF2563EB), 'name': 'Blue'},
      {'color': Color(0xFF10B981), 'name': 'Green'},
      {'color': Color(0xFFEC4899), 'name': 'Pink'},
      {'color': Color(0xFFDC2626), 'name': 'Red'},
      {'color': Color(0xFFF97316), 'name': 'Orange'},
    ];
  }
}
