import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'search_screen.dart';

class CollectionScreen extends StatefulWidget {
  final String category;
  final String label;
  final String? initialSubCategory;

  const CollectionScreen({
    super.key,
    required this.category,
    required this.label,
    this.initialSubCategory,
  });

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialSubCategory ?? 'All items';
  }

  /// Dynamically build subcategory list from actual products.
  /// This means adding a new product with any subCategory automatically
  /// shows up as a chip — no code changes needed.
  List<String> get _subCats {
    final subs = allProducts
        .where((p) => p.category == widget.category && p.subCategory.isNotEmpty)
        .map((p) => p.subCategory)
        .toSet()
        .toList();
    subs.sort();
    return ['All items', ...subs];
  }

  List<Product> get _products {
    final categoryProducts =
        allProducts.where((p) => p.category == widget.category).toList();

    if (_selected == 'All items') return categoryProducts;

    // Filter directly by the subCategory field — no string heuristics needed.
    return categoryProducts
        .where((p) => p.subCategory == _selected)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final subCats = _subCats;
    final products = _products;

    // If the previously selected chip no longer exists (e.g. after hot-reload),
    // fall back to 'All items'.
    if (!subCats.contains(_selected)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _selected = 'All items');
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              floating: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                'Royal Luxora',
                style: GoogleFonts.playfairDisplay(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: AppColors.primary),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SearchScreen()),
                  ),
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: SectionHeader(
                  label: widget.label,
                  title: widget.category == 'Accessories'
                      ? 'Accessories Collection'
                      : "${widget.category}'s Collection",
                  subtitle: widget.category == 'Accessories'
                      ? 'Curated luxury pieces for the modern aristocrat.'
                      : 'Curated luxury for the discerning ${widget.category.toLowerCase()}.',
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: CategoryChips(
                  categories: subCats,
                  selected: _selected,
                  onSelected: (c) => setState(() => _selected = c),
                ),
              ),
            ),

            if (products.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Icon(Icons.search_off,
                          size: 60, color: AppColors.textLight),
                      const SizedBox(height: 14),
                      Text(
                        'No products found in $_selected',
                        style: GoogleFonts.inter(
                            fontSize: 14, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.62,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductCard(product: products[index]),
                    childCount: products.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
