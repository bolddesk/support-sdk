import 'package:bolddesksdk_flutter_sample/constants/colors.dart';
import 'package:flutter/material.dart';

class FeatureItem {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  FeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });
}

class StockItem {
  final String stockName;
  final String stockRate;
  final String stockPercentage;
  final String stockImage;

  StockItem({
    required this.stockName,
    required this.stockRate,
    required this.stockPercentage,
    required this.stockImage,
  });
}

class CommonFeatureCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const CommonFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/investment');
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1018280F),
              blurRadius: 4,
              spreadRadius: -2,
              offset: Offset(0, 2),
            ),
            BoxShadow(
              color: Color(0x1018281A),
              blurRadius: 8,
              spreadRadius: -2,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon top-left
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              child: Image.asset(icon, width: 22, height: 22),
            ),
            const SizedBox(height: 18),
            // title
            Text(
              title,
              style: TextStyle(
                color: AppColors.darkText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            // subtitle
            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StockCards extends StatelessWidget {
  const StockCards({
    super.key,
    required this.stockName,
    required this.stockPercentage,
    required this.stockRate,
    required this.stockImage,
  });
  final String stockName;
  final String stockRate;
  final String stockPercentage;
  final String stockImage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/investment');
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFFF9F5FF),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stockName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
              ),
            ),
            Text(
              stockRate,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.greyLight,
              ),
            ),
            Image.asset(stockImage),
            Text(
              stockPercentage,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class StockGrid extends StatelessWidget {
  final List<StockItem> items;
  final double spacing;
  const StockGrid({super.key, required this.items, this.spacing = 16});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
      ),
      itemBuilder: (context, index) {
        final it = items[index];
        return StockCards(
          stockName: it.stockName,
          stockPercentage: it.stockPercentage,
          stockRate: it.stockRate,
          stockImage: it.stockImage,
        );
      },
    );
  }
}

class FeaturesGrid extends StatelessWidget {
  final List<FeatureItem> items;
  final double spacing;
  const FeaturesGrid({super.key, required this.items, this.spacing = 16});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, index) {
        final it = items[index];
        return CommonFeatureCard(
          icon: it.icon,
          title: it.title,
          subtitle: it.subtitle,
        );
      },
    );
  }
}
