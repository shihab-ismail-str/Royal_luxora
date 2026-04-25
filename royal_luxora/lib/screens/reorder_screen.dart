import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../widgets/widgets.dart';
import '../models/models.dart';
import 'order_confirmation_screen.dart';

class ReorderScreen extends StatefulWidget {
  final OrderHistoryItem order;
  const ReorderScreen({super.key, required this.order});

  @override
  State<ReorderScreen> createState() => _ReorderScreenState();
}

class _ReorderScreenState extends State<ReorderScreen> {
  int _qty = 1;

  double get _subtotal => widget.order.price * _qty;
  double get _tax => _subtotal * 0.075;
  double get _total => _subtotal + _tax;

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
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(Icons.arrow_back, color: AppColors.primary),
                            ),
                            const SizedBox(width: 12),
                            Text('Reorder Items',
                                style: GoogleFonts.inter(
                                    fontSize: 15, fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary)),
                          ],
                        ),
                        const Icon(Icons.more_vert, color: AppColors.textSecondary),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text('LAST PURCHASED ${widget.order.date.toUpperCase()}',
                        style: GoogleFonts.inter(
                          fontSize: 10, color: AppColors.primary,
                          fontWeight: FontWeight.w600, letterSpacing: 1,
                        )),
                    const SizedBox(height: 6),
                    Text('Review Your\nSelects',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 28, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 24),

                    // Item Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8)],
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ProductImage(imageUrl: widget.order.imageUrl, width: 70, height: 70, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.order.orderId,
                                    style: GoogleFonts.inter(
                                        fontSize: 11, color: AppColors.textSecondary)),
                                Text(widget.order.productName,
                                    style: GoogleFonts.inter(
                                        fontSize: 14, fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary)),
                                Text(widget.order.date,
                                    style: GoogleFonts.inter(
                                        fontSize: 11, color: AppColors.textSecondary)),
                                const SizedBox(height: 6),
                                Text('\$${widget.order.price.toStringAsFixed(0)}',
                                    style: GoogleFonts.inter(
                                        fontSize: 15, fontWeight: FontWeight.w700,
                                        color: AppColors.primary)),
                              ],
                            ),
                          ),
                          // Qty Stepper
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() => _qty++),
                                child: Container(
                                  width: 28, height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface, borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.add, size: 14, color: AppColors.primary),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('$_qty',
                                    style: GoogleFonts.inter(
                                        fontSize: 14, fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary)),
                              ),
                              GestureDetector(
                                onTap: () { if (_qty > 1) setState(() => _qty--); },
                                child: Container(
                                  width: 28, height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface, borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.remove, size: 14, color: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Summary
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _Row(label: 'Subtotal', value: '\$${_subtotal.toStringAsFixed(2)}'),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping',
                                  style: GoogleFonts.inter(
                                      fontSize: 13, color: AppColors.textSecondary)),
                              Text('Express (Free)',
                                  style: GoogleFonts.inter(
                                      fontSize: 13, fontWeight: FontWeight.w600,
                                      color: AppColors.primary)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _Row(label: 'Estimated Tax', value: '\$${_tax.toStringAsFixed(2)}'),
                          const SizedBox(height: 16),
                          const Divider(color: AppColors.divider),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('TOTAL AMOUNT',
                                      style: GoogleFonts.inter(
                                          fontSize: 10, color: AppColors.textSecondary, letterSpacing: 1)),
                                  Text('\$${_total.toStringAsFixed(2)}',
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 26, fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      )),
                                ],
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

            // Confirm Order Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: SizedBox(
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
                      Text('Confirm & Place Order',
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  const _Row({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
        Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
      ],
    );
  }
}
