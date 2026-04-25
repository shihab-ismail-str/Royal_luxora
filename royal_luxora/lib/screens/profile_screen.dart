import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/widgets.dart';
import 'order_history_screen.dart';
import 'address_screen.dart';
import 'login_screen.dart';
import 'cart_screen.dart';
import 'payment_methods_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Royal Luxora',
                        style: GoogleFonts.inter(
                            fontSize: 16, fontWeight: FontWeight.w700,
                            color: AppColors.primary)),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartScreen()),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Avatar
              Stack(
                children: [
                  Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3D1F8C), Color(0xFF6B3FD4)],
                        begin: Alignment.topLeft, end: Alignment.bottomRight,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ProductImage(
                      imageUrl: 'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: 28, height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary, shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text('Eleanor Vance',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 22, fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 4),
              Text('eleanor.vance@atelier.com',
                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              const SizedBox(height: 24),

              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text('✦', style: TextStyle(color: AppColors.primary, fontSize: 14)),
                                const Text('✦', style: TextStyle(color: AppColors.primary, fontSize: 10)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('12',
                                style: GoogleFonts.playfairDisplay(
                                    fontSize: 28, fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary)),
                            Text('ORDERS PLACED',
                                style: GoogleFonts.inter(
                                    fontSize: 10, color: AppColors.textSecondary, letterSpacing: 1)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.label_outline, color: Colors.white70, size: 20),
                            const SizedBox(height: 8),
                            Text('Gold',
                                style: GoogleFonts.playfairDisplay(
                                    fontSize: 24, fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text('MEMBER STATUS',
                                style: GoogleFonts.inter(
                                    fontSize: 10, color: Colors.white60, letterSpacing: 1)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Menu Items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _MenuTile(
                      icon: Icons.history_outlined,
                      label: 'Order History',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const OrderHistoryScreen())),
                    ),
                    _MenuTile(
                      icon: Icons.location_on_outlined,
                      label: 'Shipping Addresses',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => AddressScreen())),
                    ),
                    _MenuTile(
                      icon: Icons.credit_card_outlined,
                      label: 'Payment Methods',
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const PaymentMethodsScreen())),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF0F0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, color: Colors.redAccent, size: 18),
                        const SizedBox(width: 8),
                        Text('Logout',
                            style: GoogleFonts.inter(
                                fontSize: 14, fontWeight: FontWeight.w600,
                                color: Colors.redAccent)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('APP VERSION 2.4.0 • THE ROYAL VELVET',
                  style: GoogleFonts.inter(
                      fontSize: 10, color: AppColors.textLight, letterSpacing: 1)),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuTile({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
        ),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: AppColors.surface, borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 14, fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary)),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }
}