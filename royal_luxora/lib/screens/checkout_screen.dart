import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../widgets/widgets.dart';
import '../data/cart_provider.dart';
import 'address_screen.dart';
import 'order_confirmation_screen.dart';
import 'payment_methods_screen.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

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
                    // AppBar row
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Text('CHECKOUT',
                            style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: AppColors.primary, letterSpacing: 1.5,
                            )),
                        const Spacer(),
                        Text('Royal Luxora',
                            style: GoogleFonts.playfairDisplay(
                              color: AppColors.primary, fontSize: 16,
                              fontStyle: FontStyle.italic, fontWeight: FontWeight.w600,
                            )),
                      ],
                    ),
                    const SizedBox(height: 28),

                    // Shipping Address
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping Address',
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 20, fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary)),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => AddressScreen()),
                          ),
                          child: Text('CHANGE',
                              style: GoogleFonts.inter(
                                fontSize: 11, fontWeight: FontWeight.w700,
                                color: AppColors.primary, letterSpacing: 1,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.surface, borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Madison Avery',
                                  style: GoogleFonts.inter(
                                      fontSize: 15, fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary)),
                              const SizedBox(height: 4),
                              Text('2480 Editorial Lane, Suite 402\nChelsea, Manhattan, NY 10011\nUnited States',
                                  style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Payment Method
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Payment Method',
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 20, fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary)),
                        GestureDetector(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => const PaymentMethodsScreen())),
                          child: Text('MANAGE',
                              style: GoogleFonts.inter(
                                fontSize: 11, fontWeight: FontWeight.w700,
                                color: AppColors.primary, letterSpacing: 1,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3D1F8C), Color(0xFF6B3FD4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.contactless_outlined, color: Colors.white70, size: 24),
                              Text('PLATINUM',
                                  style: GoogleFonts.inter(
                                    color: Colors.white70, fontSize: 12,
                                    letterSpacing: 2, fontWeight: FontWeight.w600,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text('ACCOUNT NUMBER',
                              style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              ...List.generate(3, (_) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  children: List.generate(4, (__) => Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    width: 5, height: 5,
                                    decoration: const BoxDecoration(
                                      color: Colors.white60, shape: BoxShape.circle,
                                    ),
                                  )),
                                ),
                              )),
                              Text('8842',
                                  style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 18,
                                    fontWeight: FontWeight.w700, letterSpacing: 2,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('CARD HOLDER',
                                      style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                                  Text('MADISON AVERY',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('EXPIRES',
                                      style: GoogleFonts.inter(color: Colors.white54, fontSize: 9, letterSpacing: 1)),
                                  Text('11 / 26',
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Order Summary
                    Text('Order Summary',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 20, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                      ),
                      child: Column(
                        children: [
                          ...cart.items.map((item) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ProductImage(imageUrl: item.product.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                                    ),
                                    Positioned(
                                      top: 4, right: 4,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary, shape: BoxShape.circle,
                                        ),
                                        child: Text('x${item.quantity}',
                                            style: GoogleFonts.inter(
                                                color: Colors.white, fontSize: 9,
                                                fontWeight: FontWeight.w700)),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.product.name,
                                          style: GoogleFonts.inter(
                                              fontSize: 14, fontWeight: FontWeight.w600,
                                              color: AppColors.textPrimary)),
                                      Text('SIZE: ${item.selectedSize}',
                                          style: GoogleFonts.inter(
                                              fontSize: 10, color: AppColors.textSecondary,
                                              letterSpacing: 0.5)),
                                      const SizedBox(height: 4),
                                      Text('\$${item.product.price.toStringAsFixed(2)}',
                                          style: GoogleFonts.inter(
                                              fontSize: 14, fontWeight: FontWeight.w700,
                                              color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                          const Divider(color: AppColors.divider),
                          const SizedBox(height: 10),
                          _SummaryRow(label: 'Subtotal', value: '\$${cart.subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 8),
                          _SummaryRow(label: 'Shipping', value: 'Free', valueColor: AppColors.primary),
                          const SizedBox(height: 8),
                          _SummaryRow(
                            label: 'Estimated Tax',
                            value: '\$${(cart.subtotal * 0.085).toStringAsFixed(2)}',
                          ),
                          const SizedBox(height: 14),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Amount',
                                  style: GoogleFonts.inter(
                                      fontSize: 15, fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary)),
                              Text(
                                '\$${(cart.total + cart.subtotal * 0.085).toStringAsFixed(2)}',
                                style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Place Order
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const OrderConfirmationScreen()),
                        (route) => route.isFirst,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Place Order',
                              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('By placing an order, you agree to our Terms',
                      style: GoogleFonts.inter(fontSize: 11, color: AppColors.textLight)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  const _SummaryRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
        Text(value,
            style: GoogleFonts.inter(
                fontSize: 13, fontWeight: FontWeight.w500,
                color: valueColor ?? AppColors.textPrimary)),
      ],
    );
  }
}
