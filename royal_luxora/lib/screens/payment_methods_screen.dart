import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});
  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  int _selectedIndex = 0;

  final _cards = [
    {'label': 'PLATINUM', 'last4': '8842', 'holder': 'MADISON AVERY', 'expires': '11 / 26'},
    {'label': 'GOLD',     'last4': '3391', 'holder': 'ELEANOR VANCE',  'expires': '05 / 28'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Text('PAYMENT METHODS',
                            style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: AppColors.primary, letterSpacing: 1.5,
                            )),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text('YOUR CARDS',
                        style: GoogleFonts.inter(
                          fontSize: 11, fontWeight: FontWeight.w600,
                          color: AppColors.primary, letterSpacing: 1.5,
                        )),
                    const SizedBox(height: 6),
                    Text('Payment Methods',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 28, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 24),
                    ..._cards.asMap().entries.map((e) {
                      final i = e.key;
                      final c = e.value;
                      final selected = _selectedIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIndex = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3D1F8C), Color(0xFF6B3FD4)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: selected ? Colors.white : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(Icons.contactless_outlined, color: Colors.white70, size: 24),
                                  Row(
                                    children: [
                                      Text(c['label']!,
                                          style: GoogleFonts.inter(
                                            color: Colors.white70, fontSize: 12,
                                            letterSpacing: 2, fontWeight: FontWeight.w600,
                                          )),
                                      if (selected) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          width: 20, height: 20,
                                          decoration: const BoxDecoration(
                                            color: Colors.white, shape: BoxShape.circle,
                                          ),
                                          child: const Icon(Icons.check, color: AppColors.primary, size: 13),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text('•••• •••• •••• ${c['last4']}',
                                  style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 18,
                                    fontWeight: FontWeight.w600, letterSpacing: 3,
                                  )),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('CARD HOLDER',
                                          style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                                      Text(c['holder']!,
                                          style: GoogleFonts.inter(
                                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('EXPIRES',
                                          style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                                      Text(c['expires']!,
                                          style: GoogleFonts.inter(
                                              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    // Add new card
                    GestureDetector(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add new card — coming soon',
                              style: GoogleFonts.inter(color: Colors.white)),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 22),
                            const SizedBox(width: 10),
                            Text('Add New Card',
                                style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text('CONFIRM SELECTION',
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
