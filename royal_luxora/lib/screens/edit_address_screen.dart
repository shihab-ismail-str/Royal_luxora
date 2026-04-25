import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class EditAddressScreen extends StatefulWidget {
  final Map<String, String>? address;
  const EditAddressScreen({super.key, this.address});
  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController _nameCtrl;
  late TextEditingController _line1Ctrl;
  late TextEditingController _cityCtrl;
  late TextEditingController _phoneCtrl;
  late TextEditingController _typeCtrl;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _nameCtrl  = TextEditingController(text: a?['name']    ?? '');
    _line1Ctrl = TextEditingController(text: a?['address'] ?? '');
    _cityCtrl  = TextEditingController(text: '');
    _phoneCtrl = TextEditingController(text: a?['phone']   ?? '');
    _typeCtrl  = TextEditingController(text: a?['type']    ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _line1Ctrl.dispose();
    _cityCtrl.dispose();
    _phoneCtrl.dispose();
    _typeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.address != null;
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
                        Text(isEdit ? 'EDIT ADDRESS' : 'NEW ADDRESS',
                            style: GoogleFonts.inter(
                              fontSize: 12, fontWeight: FontWeight.w700,
                              color: AppColors.primary, letterSpacing: 1.5,
                            )),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Text(isEdit ? 'Edit Address' : 'New Address',
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 28, fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary)),
                    const SizedBox(height: 28),
                    _field('LABEL (e.g. Home, Studio)', _typeCtrl),
                    const SizedBox(height: 16),
                    _field('FULL NAME', _nameCtrl),
                    const SizedBox(height: 16),
                    _field('ADDRESS', _line1Ctrl, maxLines: 3),
                    const SizedBox(height: 16),
                    _field('PHONE NUMBER', _phoneCtrl,
                        keyboardType: TextInputType.phone),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final newAddress = {
                      'type':    _typeCtrl.text.trim(),
                      'name':    _nameCtrl.text.trim(),
                      'address': _line1Ctrl.text.trim(),
                      'phone':   _phoneCtrl.text.trim(),
                    };
                    Navigator.pop(context, newAddress);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  child: Text('SAVE ADDRESS',
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.5)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController ctrl,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 1)),
        const SizedBox(height: 8),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }
}