import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'collection_screen.dart';
import 'search_screen.dart';
import 'menu_screen.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  String _buildSubtitle(String category) {
    final subs = allProducts
        .where((p) => p.category == category && p.subCategory.isNotEmpty)
        .map((p) => p.subCategory)
        .toSet()
        .toList()
      ..sort();
    return subs.join(' • ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              floating: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MenuScreen()),
                    ),
                    child: const Icon(Icons.menu, color: AppColors.primary),
                  ),
                  const Spacer(),
                  Text(
                    'Royal Luxora',
                    style: GoogleFonts.playfairDisplay(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SearchScreen()),
                    ),
                    child: const Icon(Icons.search, color: AppColors.primary),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('THE COLLECTIONS',
                        style: GoogleFonts.inter(
                          fontSize: 11, color: AppColors.primary,
                          fontWeight: FontWeight.w600, letterSpacing: 1.5,
                        )),
                    const SizedBox(height: 6),
                    Text('Shop by Category',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 26, fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        )),
                    const SizedBox(height: 4),
                    Text('Curated luxury for every occasion.',
                        style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  children: [
                    _CollectionTile(
                      label: "CURATION 01",
                      title: "Men's Collection",
                      subtitle: _buildSubtitle('Men'),
                      imageUrl: 'assets/images/photo-1617127365659-c47fa864d8bc.jpg',
                      category: 'Men',
                    ),
                    const SizedBox(height: 14),
                    _CollectionTile(
                      label: "CURATION 02",
                      title: "Women's Collection",
                      subtitle: _buildSubtitle('Women'),
                      imageUrl: 'assets/images/photo-1490481651871-ab68de25d43d.jpg',
                      category: 'Women',
                    ),
                    const SizedBox(height: 14),
                    _CollectionTile(
                      label: "THE ATELIER",
                      title: "Accessories Selection",
                      subtitle: _buildSubtitle('Accessories'),
                      imageUrl: 'assets/images/photo-1548036328-c9fa89d128fa.jpg',
                      category: 'Accessories',
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CollectionTile extends StatelessWidget {
  final String label;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String category;

  const _CollectionTile({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CollectionScreen(category: category, label: label),
        ),
      ),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ProductImage(imageUrl: imageUrl, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.55),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 18,
              left: 18,
              right: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: GoogleFonts.inter(
                          color: Colors.white70, fontSize: 10,
                          letterSpacing: 1.5, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(title,
                      style: GoogleFonts.playfairDisplay(
                          color: Colors.white, fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: GoogleFonts.inter(color: Colors.white70, fontSize: 11)),
                ],
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
