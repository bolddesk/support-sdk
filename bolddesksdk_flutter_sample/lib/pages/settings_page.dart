import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/styles.dart';
import '../widgets/common_card.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedThemeIndex = 0;
  bool _followDeviceTheme = false;
  String _selectedFont = 'Roboto';
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: isDark ? AppColors.lightText : AppColors.darkText,
            ),
          ),
          title: Text(
            'Settings',
            style: AppStyles.heading2.copyWith(
              color: isDark ? AppColors.lightText : AppColors.darkText,
            ),
          ),
          elevation: 0,
          backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Themes',
                style: AppStyles.heading3.copyWith(
                  color: isDark ? AppColors.lightText : AppColors.darkText,
                ),
              ),
              const SizedBox(height: 16),
              CommonCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.palette, color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          'Choose Theme',
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedThemeIndex = index;
                            });
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: [
                                Colors.blue,
                                Colors.green,
                                Colors.pink,
                                Colors.red,
                                Colors.orange,
                              ][index],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedThemeIndex == index
                                    ? AppColors.darkText
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: _selectedThemeIndex == index
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 20,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              CommonCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.devices, color: AppColors.primary, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          'Follow Device Theme',
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: _followDeviceTheme,
                      onChanged: (value) {
                        setState(() {
                          _followDeviceTheme = value;
                        });
                      },
                      activeThumbColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              CommonCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.dark_mode,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Dark Theme',
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.setTheme(value);
                      },
                      activeThumbColor: AppColors.primary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Personalization',
                style: AppStyles.heading3.copyWith(
                  color: isDark ? AppColors.lightText : AppColors.darkText,
                ),
              ),
              const SizedBox(height: 16),

              CommonCard(
                padding: const EdgeInsets.all(16),
                onTap: () {
                  _showFontPicker(context, isDark);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.text_fields,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Fonts',
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _selectedFont,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              CommonCard(
                padding: const EdgeInsets.all(16),
                onTap: () {
                  _showLanguagePicker(context, isDark);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Language',
                          style: AppStyles.bodyMedium.copyWith(
                            color: isDark
                                ? AppColors.lightText
                                : AppColors.darkText,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      _selectedLanguage,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFontPicker(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: isDark ? AppColors.darkBg : AppColors.lightBg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Select Font',
                  style: AppStyles.heading3.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),
              ),
              ...['Roboto', 'Inter', 'Poppins', 'Open Sans'].map((font) {
                return ListTile(
                  title: Text(
                    font,
                    style: TextStyle(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                      fontFamily: font,
                    ),
                  ),
                  trailing: _selectedFont == font
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFont = font;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showLanguagePicker(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: isDark ? AppColors.darkBg : AppColors.lightBg,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Select Language',
                  style: AppStyles.heading3.copyWith(
                    color: isDark ? AppColors.lightText : AppColors.darkText,
                  ),
                ),
              ),
              ...['English', 'Spanish', 'French', 'German', 'Hindi'].map((
                lang,
              ) {
                return ListTile(
                  title: Text(
                    lang,
                    style: TextStyle(
                      color: isDark ? AppColors.lightText : AppColors.darkText,
                    ),
                  ),
                  trailing: _selectedLanguage == lang
                      ? Icon(Icons.check, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedLanguage = lang;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
