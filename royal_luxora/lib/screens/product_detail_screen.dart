import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme.dart';
import '../models/models.dart';
import '../data/cart_provider.dart';
import '../widgets/widgets.dart';
import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;
  bool _addedToCart = false;

  // FIX: Added all 9 missing color hex values from models.dart
  static const _colorMap = {
    '#111827': Color(0xFF111827),
    '#1E3A5F': Color(0xFF1E3A5F),
    '#1F2937': Color(0xFF1F2937),
    '#374151': Color(0xFF374151),
    '#3D1F8C': Color(0xFF3D1F8C),
    '#4B5563': Color(0xFF4B5563),
    '#4C1D95': Color(0xFF4C1D95),
    '#6B21A8': Color(0xFF6B21A8),
    '#6B7280': Color(0xFF6B7280),
    '#7B1D1D': Color(0xFF7B1D1D),
    '#7C3AED': Color(0xFF7C3AED),
    '#93C5FD': Color(0xFF93C5FD),
    '#9CA3AF': Color(0xFF9CA3AF),
    '#BE185D': Color(0xFFBE185D),
    '#C4A8E0': Color(0xFFC4A8E0),
    '#D1D5DB': Color(0xFFD1D5DB),
    '#D97706': Color(0xFFD97706),
    '#E5E7EB': Color(0xFFE5E7EB),
    '#F3F4F6': Color(0xFFF3F4F6),
    '#F9FAFB': Color(0xFFF9FAFB),
    '#FDE68A': Color(0xFFFDE68A),
    '#FFFFFF': Color(0xFFFFFFFF),
  };

  Color _parseColor(String hex) => _colorMap[hex] ?? AppColors.primary;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Hero Image
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                backgroundColor: AppColors.background,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back, color: AppColors.primary, size: 20),
                  ),
                ),
                // FIX: Removed the empty shopping bag button that just called Navigator.pop()
                // Replaced with a real cart navigation button
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartScreen()),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.shopping_bag_outlined, color: AppColors.primary, size: 20),
                      ),
                    ),
                  ),
                ],
                title: Text(
                  p.name.toUpperCase(),
                  style: GoogleFonts.inter(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1.5),
                ),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: ProductImage(imageUrl: p.imageUrl, fit: BoxFit.cover),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Badge + Rating
                      Row(
                        children: [
                          Text(
                            p.badge != null
                                ? (p.badge == 'LIMITED' ? 'LIMITED EDITION' : p.badge!)
                                : 'LIMITED EDITION',
                            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary, letterSpacing: 1),
                          ),
                          const Spacer(),
                          const Icon(Icons.star, color: Color(0xFFFFB800), size: 16),
                          const SizedBox(width: 4),
                          Text(p.rating.toString(),
                              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(p.name,
                          style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                      const SizedBox(height: 8),
                      Text('\$${p.price.toStringAsFixed(2)}',
                          style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      const SizedBox(height: 16),
                      Text(
                        p.description.isNotEmpty
                            ? p.description
                            : 'A masterclass in editorial tailoring. This structured piece features exaggerated details and a refined silhouette, hand-finished in our signature Atelier hue.',
                        style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.6),
                      ),
                      const SizedBox(height: 28),

                      // Color Selection
                      if (p.colors.isNotEmpty) ...[
                        Text('COLOR', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 1)),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(p.colors.length, (i) => GestureDetector(
                            onTap: () => setState(() => _selectedColorIndex = i),
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: _parseColor(p.colors[i]),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _selectedColorIndex == i ? AppColors.primary : Colors.transparent,
                                  width: 2.5,
                                ),
                                boxShadow: [
                                  if (_selectedColorIndex == i)
                                    BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8),
                                ],
                              ),
                            ),
                          )),
                        ),
                        const SizedBox(height: 28),
                      ],

                      // Size Selection
                      if (p.sizes.isNotEmpty) ...[
                        Row(
                          children: [
                            Text('SIZE', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary, letterSpacing: 1)),
                            const Spacer(),
                            Text('Size Guide',
                                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primary, decoration: TextDecoration.underline)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: List.generate(p.sizes.length, (i) => GestureDetector(
                            onTap: () => setState(() => _selectedSizeIndex = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 52,
                              height: 44,
                              decoration: BoxDecoration(
                                color: _selectedSizeIndex == i ? AppColors.primary : AppColors.surface,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                p.sizes[i],
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedSizeIndex == i ? Colors.white : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          )),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Add to Cart Button
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              color: AppColors.background,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.read<CartProvider>().addToCart(
                    p,
                    size: p.sizes.isNotEmpty ? p.sizes[_selectedSizeIndex] : 'M',
                    color: p.colors.isNotEmpty ? p.colors[_selectedColorIndex] : '',
                  );
                  setState(() => _addedToCart = true);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${p.name} added to cart', style: GoogleFonts.inter(color: Colors.white)),
                    backgroundColor: AppColors.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    duration: const Duration(seconds: 2),
                  ));
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                label: Text(
                  _addedToCart ? 'ADDED TO CART ✓' : 'ADD TO CART',
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _addedToCart ? AppColors.success : AppColors.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
