import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedCurrency = 'USD';
  bool emailNotifications = true;
  bool pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: AppColors.primary,
                          child: Text(
                            'JD',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'john.doe@example.com',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0),
            ),
            // Account Settings
            _buildSettingsSection(
              title: 'Account',
              items: [
                _SettingItem(
                  title: 'Currency',
                  subtitle: selectedCurrency,
                  icon: Icons.monetization_on_outlined,
                  onTap: () => _showCurrencyPicker(),
                ),
                _SettingItem(
                  title: 'Email',
                  subtitle: 'john.doe@example.com',
                  icon: Icons.email_outlined,
                ),
                _SettingItem(
                  title: 'Password',
                  subtitle: 'Change your password',
                  icon: Icons.lock_outlined,
                  onTap: () {},
                ),
              ],
              delay: 200,
            ),
            // Notifications
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notifications',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildToggleSetting(
                    title: 'Email Notifications',
                    subtitle: 'Receive email updates',
                    value: emailNotifications,
                    onChanged: (value) {
                      setState(() => emailNotifications = value);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildToggleSetting(
                    title: 'Push Notifications',
                    subtitle: 'Receive push alerts',
                    value: pushNotifications,
                    onChanged: (value) {
                      setState(() => pushNotifications = value);
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
            // About
            _buildSettingsSection(
              title: 'About',
              items: [
                _SettingItem(
                  title: 'Version',
                  subtitle: '1.0.0',
                  icon: Icons.info_outlined,
                ),
                _SettingItem(
                  title: 'Privacy Policy',
                  subtitle: 'View our policy',
                  icon: Icons.privacy_tip_outlined,
                ),
                _SettingItem(
                  title: 'Terms of Service',
                  subtitle: 'View terms',
                  icon: Icons.description_outlined,
                ),
              ],
              delay: 600,
            ),
            // Sign Out
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement sign out
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    'Sign Out',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<_SettingItem> items,
    required int delay,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...items.asMap().entries.map((entry) {
            int index = entry.key;
            _SettingItem item = entry.value;
            return _buildSettingItem(
              item: item,
              delay: delay + (index * 50),
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay), duration: 600.ms);
  }

  Widget _buildSettingItem({
    required _SettingItem item,
    required int delay,
  }) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Icon(item.icon, color: AppColors.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: AppColors.textTertiary,
              size: 20,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: delay), duration: 600.ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildToggleSetting({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  void _showCurrencyPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Select Currency',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ...['USD', 'EUR', 'GBP', 'NGN', 'INR', 'AUD', 'CAD'].map((currency) {
              return ListTile(
                title: Text(currency),
                trailing: selectedCurrency == currency
                    ? Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => selectedCurrency = currency);
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class _SettingItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  _SettingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });
}
