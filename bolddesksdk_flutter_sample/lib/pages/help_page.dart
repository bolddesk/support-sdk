import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../data/mock_data.dart';
import '../widgets/common_card.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final faqData = MockData.getFaqData();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help Page',
              style: AppStyles.heading1.copyWith(
                color: isDark ? AppColors.lightText : AppColors.darkText,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Frequently Asked Questions',
              style: AppStyles.heading2.copyWith(
                color: isDark ? AppColors.lightText : AppColors.darkText,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqData.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = faqData[index];
                final isExpanded = expandedIndex == index;

                return CommonCard(
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index;
                    });
                  },
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item['question']!,
                              style: AppStyles.bodyLarge.copyWith(
                                color: isDark
                                    ? AppColors.lightText
                                    : AppColors.darkText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Icon(
                            isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      if (isExpanded) ...[
                        const SizedBox(height: 12),
                        Text(
                          item['answer']!,
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.greyLight
                                : AppColors.grey,
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            CommonCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: AppColors.primary.withAlpha(10),
              child: Column(
                children: [
                  Icon(Icons.help_outline, color: AppColors.primary, size: 40),
                  const SizedBox(height: 12),
                  Text(
                    'Need More Help?',
                    style: AppStyles.heading3.copyWith(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Contact our support team for additional assistance',
                    style: AppStyles.bodyMedium.copyWith(
                      color: isDark ? AppColors.greyLight : AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(
                      'Contact Support',
                      style: AppStyles.labelLarge.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
