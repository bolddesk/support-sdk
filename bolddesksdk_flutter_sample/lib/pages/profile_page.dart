import 'package:bd_support_sdk/bolddesk_support_sdk.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Banner + fade
                SizedBox(
                  height: 248,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/ProfileBanner.png',
                        width: double.infinity,
                        height: 248,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: -12,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/BannerFade.png',
                          width: double.infinity,
                          height: 35,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),

                // Top-right menu
                Positioned(
                  top: 56,
                  right: 16,
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                  ),
                ),

                // Profile overlay
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24, bottom: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Olivia Rhye",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101828),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "UPI ID: Olivi.ye01-2@okhdfcbank",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF344054),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text(
                              "9191323909",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF344054),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF9F5FF),
                                border: Border.all(
                                  color: const Color(0xFFE9D7FE),
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Verified.png',
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "UPI Number",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF6941C6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Floating avatar + QR badge
                Positioned(
                  bottom: 14,
                  right: 16,
                  child: SizedBox(
                    width: 90,
                    height: 90,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: const AssetImage(
                            'assets/images/ProfileAvatar.png',
                          ),
                        ),
                        Positioned(
                          bottom: -2,
                          right: -2,
                          child: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: const Color(0xFFEAECF0),
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0x1018280F,
                                    // ignore: deprecated_member_use
                                  ).withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/images/QrCode.png',
                                width: 18,
                                height: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Rewards + Refer
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE4EF),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Reward.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "7 Rewards",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFC11574),
                                ),
                              ),
                              Text(
                                "View Now",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFC11574),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 54,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/Refer.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Get ₹20",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF026AA2),
                                ),
                              ),
                              Text(
                                "Refer a friend",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF026AA2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Payment methods
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  border: Border.all(color: const Color(0xFFEAECF0)),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Set up payment methods 1/3",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF101828),
                          ),
                        ),
                        Image.asset(
                          'assets/images/ChevronRight.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: PaymentCard(
                            icon: 'assets/images/BankAccount.png',
                            label: "Bank Account",
                            subLabel: "2 accounts",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        PaymentCard(
                          icon: 'assets/images/CreditCard.png',
                          label: "Credit Card",
                          subLabel: "Pay with UPI",
                        ),
                        PaymentCard(
                          icon: 'assets/images/upilite.png',
                          label: "UPI Lite",
                          subLabel: "Pay PIN-Free",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Main list
            Column(
              children: [
                ListItem(
                  icon: 'assets/images/Help.png',
                  label: "Get Help",
                  showRedDot: true,
                  onTap: () {
                    BoldDeskSupportSDK.showHome();
                  },
                ),
                ListItem(
                  icon: 'assets/images/Chat.png',
                  label: "Contact us",
                  showRedDot: true,
                  onTap: () {},
                ),
                ListItem(
                  icon: 'assets/images/Wallet.png',
                  label: "Pay with credit or debit cards",
                ),
                ListItem(
                  icon: 'assets/images/QrCode.png',
                  label: "Your QR code",
                ),
                ListItem(
                  icon: 'assets/images/History.png',
                  label: "Transaction History",
                ),
                ListItem(icon: 'assets/images/Setting.png', label: "Settings"),
              ],
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  final String icon;
  final String label;
  final String subLabel;
  final double? width;
  final double? height;

  const PaymentCard({
    super.key,
    required this.icon,
    required this.label,
    required this.subLabel,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(icon, width: width ?? 48, height: height ?? 48),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF101828),
          ),
        ),
        Text(
          subLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF344054),
          ),
        ),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool showRedDot;
  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.icon,
    required this.label,
    this.showRedDot = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(icon, width: 22, height: 22),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF344054),
                  ),
                ),
              ],
            ),
            if (showRedDot)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: const Color(0xFFD92D20),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
