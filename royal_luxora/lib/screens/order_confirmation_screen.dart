import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../widgets/widgets.dart';
import '../data/cart_provider.dart';
import 'main_layout.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

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
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
                          child: const Icon(Icons.close, color: AppColors.textSecondary),
                        ),
                        Text('Order Status',
                            style: GoogleFonts.inter(
                                fontSize: 15, fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary)),
                        const SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 36),

                    // Success Icon
                    Center(
                      child: Container(
                        width: 80, height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.15),
                              blurRadius: 20,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.check_circle_outline,
                            color: AppColors.primary, size: 44),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Center(
                      child: Text('Order Confirmed!',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 28, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          )),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Thank you for your purchase. Your curated\nselection is being prepared for shipment.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 13, color: AppColors.textSecondary, height: 1.6,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Order Info
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 42, height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.surface, borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.inbox_outlined, color: AppColors.primary, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ORDER NUMBER',
                                      style: GoogleFonts.inter(
                                          fontSize: 10, color: AppColors.textSecondary, letterSpacing: 1)),
                                  Text('#VA-10293',
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 18, fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: AppColors.divider, height: 1),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: 42, height: 42,
                                decoration: BoxDecoration(
                                  color: AppColors.surface, borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.local_shipping_outlined,
                                    color: AppColors.primary, size: 22),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('ESTIMATED DELIVERY',
                                      style: GoogleFonts.inter(
                                          fontSize: 10, color: AppColors.textSecondary, letterSpacing: 1)),
                                  Text('Oct 12, 2024',
                                      style: GoogleFonts.playfairDisplay(
                                          fontSize: 18, fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Confirmed items graphic
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: ProductImage(imageUrl:'assets/images/photo-1490481651871-ab68de25d43d.jpg', fit: BoxFit.cover, width: double.infinity),
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12), 
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Items Confirmed',
                                    style: GoogleFonts.inter(
                                        fontSize: 12, fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    ...[
                                      const Color(0xFF6B21A8),
                                      const Color(0xFF1F2937),
                                    ].map((c) => Container(
                                          margin: const EdgeInsets.only(right: 4),
                                          width: 24, height: 24,
                                          decoration: BoxDecoration(
                                            color: c, shape: BoxShape.circle,
                                          ),
                                        )),
                                    Container(
                                      width: 24, height: 24,
                                      decoration: BoxDecoration(
                                        color: AppColors.primary, shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Text('+1',
                                            style: TextStyle(color: Colors.white, fontSize: 9)),
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
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Back to Shop
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CartProvider>().clearCart();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainLayout()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text('Back to Shop',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('THE VIOLET ATELIER — 2026',
                    style: GoogleFonts.inter(fontSize: 10, color: AppColors.textLight, letterSpacing: 1)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
