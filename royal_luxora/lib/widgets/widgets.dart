import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/models.dart';
import '../data/cart_provider.dart';
import '../screens/product_detail_screen.dart';
import '../screens/search_screen.dart';
import '../screens/cart_screen.dart';

// ─── Bottom Nav Bar ──────────────────────────────────────────────────────────

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(icon: Icons.home_outlined, label: 'HOME', index: 0, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.shopping_bag_outlined, label: 'SHOP', index: 1, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.shopping_cart_outlined, label: 'CART', index: 2, current: currentIndex, onTap: onTap),
              _NavItem(icon: Icons.person_outline, label: 'PROFILE', index: 3, current: currentIndex, onTap: onTap),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final Function(int) onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == current;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: isSelected
            ? BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20))
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textLight, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textLight,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Product Image (supports local assets AND network URLs) ──────────────────

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  bool get _isLocal =>
      imageUrl.startsWith('assets/') && !imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    if (_isLocal) {
      // FIX: Use Image.asset for local asset files, NOT Image.network
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        color: AppColors.surface,
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 1),
        ),
      ),
      errorWidget: (context, url, error) => _placeholder(),
    );
  }

  Widget _placeholder() => Container(
        width: width,
        height: height,
        color: AppColors.surface,
        child: const Center(
          child: Icon(Icons.image_outlined, color: AppColors.textLight, size: 40),
        ),
      );
}

// ─── Product Card ─────────────────────────────────────────────────────────────

class ProductCard extends StatelessWidget {
  final Product product;
  final CartProvider? cart;

  const ProductCard({super.key, required this.product, this.cart});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ProductImage(imageUrl: product.imageUrl, fit: BoxFit.cover),
                  if (product.badge != null)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: product.badge == 'LIMITED' ? AppColors.primaryLight : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          product.badge!,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: product.badge == 'LIMITED' ? Colors.white : AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            product.subtitle,
            style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.price),
          ),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ─── Section Header ───────────────────────────────────────────────────────────

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.label, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary, letterSpacing: 1.5)),
        const SizedBox(height: 4),
        Text(title, style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        if (subtitle != null) ...[
          const SizedBox(height: 6),
          Text(subtitle!, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
        ],
      ],
    );
  }
}

// ─── Category Chips ───────────────────────────────────────────────────────────

class CategoryChips extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelected;

  const CategoryChips({super.key, required this.categories, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((cat) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => onSelected(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected == cat ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                cat,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: selected == cat ? Colors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}

// ─── Primary Button ───────────────────────────────────────────────────────────

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool fullWidth;

  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon, this.fullWidth = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 8)],
            Text(label),
          ],
        ),
      ),
    );
  }
}

// ─── Luxora AppBar helper ─────────────────────────────────────────────────────

PreferredSizeWidget luxoraAppBar({
  required String title,
  bool showSearch = true,
  bool showCart = false,
  bool showBack = false,
  BuildContext? context,
  bool isItalic = false,
}) {
  return AppBar(
    backgroundColor: AppColors.background,
    elevation: 0,
    automaticallyImplyLeading: showBack,
    leading: showBack && context != null
        ? IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.primary), onPressed: () => Navigator.pop(context))
        : null,
    title: Text(
      title,
      style: isItalic
          ? GoogleFonts.playfairDisplay(color: AppColors.primary, fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.w600)
          : GoogleFonts.inter(color: AppColors.primary, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.5),
    ),
    centerTitle: true,
    actions: [
      if (showSearch)
        Builder(builder: (ctx) => IconButton(
          icon: const Icon(Icons.search, color: AppColors.primary),
          onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SearchScreen())),
        )),
      if (showCart)
        Builder(builder: (ctx) => IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
          onPressed: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CartScreen())),
        )),
    ],
  );
}
