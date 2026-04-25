import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  final _focusNode = FocusNode();
  List<Product> _results = [];
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus with blinking cursor
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _search(String q) {
    final query = q.toLowerCase().trim();
    setState(() {
      _hasSearched = query.isNotEmpty;
      if (query.isEmpty) {
        _results = [];
      } else {
        _results = allProducts
            .where((p) =>
                p.name.toLowerCase().contains(query) ||
                p.category.toLowerCase().contains(query) ||
                p.subtitle.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query))
            .toList();

        // If exact match by name, navigate directly to product
        final exact = allProducts.firstWhere(
          (p) => p.name.toLowerCase() == query,
          orElse: () => allProducts.first,
        );
        if (_results.length == 1 ||
            allProducts.any((p) => p.name.toLowerCase() == query)) {
          // Don't auto-navigate; show results instead
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _ctrl,
          focusNode: _focusNode,
          autofocus: true,
          onChanged: _search,
          cursorColor: AppColors.primary,
          cursorWidth: 2,
          showCursor: true,
          decoration: InputDecoration(
            hintText: 'Search the collection...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            filled: false,
            hintStyle: GoogleFonts.inter(color: AppColors.textLight, fontSize: 15),
          ),
          style: GoogleFonts.inter(fontSize: 15, color: AppColors.textPrimary),
        ),
        actions: [
          if (_ctrl.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.textSecondary),
              onPressed: () {
                _ctrl.clear();
                _search('');
              },
            ),
        ],
      ),
      body: _ctrl.text.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search, size: 60, color: AppColors.textLight),
                  const SizedBox(height: 14),
                  Text(
                    'Search for dresses, bags, suits...',
                    style: GoogleFonts.inter(
                        fontSize: 14, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start typing to find products',
                    style: GoogleFonts.inter(
                        fontSize: 12, color: AppColors.textLight),
                  ),
                ],
              ),
            )
          : _results.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.search_off,
                          size: 60, color: AppColors.textLight),
                      const SizedBox(height: 14),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'No results found. Please try searching for a different product.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Search Suggestions
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: ['Gown', 'Blazer', 'Watch', 'Bag', 'Belt']
                            .map((s) => GestureDetector(
                                  onTap: () {
                                    _ctrl.text = s;
                                    _search(s);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(s,
                                        style: GoogleFonts.inter(
                                            fontSize: 12,
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20, 12, 20, 4),
                      child: Text(
                        '${_results.length} result${_results.length == 1 ? '' : 's'} for "${_ctrl.text}"',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: _results.length,
                        itemBuilder: (ctx, i) =>
                            ProductCard(product: _results[i]),
                      ),
                    ),
                  ],
                ),
    );
  }
}
