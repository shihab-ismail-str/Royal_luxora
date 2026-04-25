# 👑 Royal Luxora — Flutter App

A pixel-perfect luxury fashion e-commerce app built in Flutter/Dart, matching the provided UI designs.

---

## 🚀 Quick Start

```bash
# 1. Install dependencies
flutter pub get

# 2. Run the app
flutter run
```

> **Minimum:** Flutter 3.10+, Dart 3.0+

---

## 📁 Project Structure

```
lib/
├── main.dart                        # App entry point + Provider setup
├── theme.dart                       # AppColors, AppTheme (global design tokens)
├── models/
│   └── models.dart                  # Product, CartItem, OrderHistoryItem + mock data
├── data/
│   └── cart_provider.dart           # ChangeNotifier — cart state management
├── widgets/
│   └── widgets.dart                 # Shared UI: ProductCard, AppBottomNav, CategoryChips, etc.
└── screens/
    ├── login_screen.dart            # Login with email/password + Google/Apple OAuth buttons
    ├── register_screen.dart         # Create Account screen
    ├── main_layout.dart             # IndexedStack + BottomNavigationBar (4 tabs)
    ├── home_screen.dart             # Hero banner, category filter chips, trending product grid
    ├── shop_screen.dart             # Collection tiles (Men / Women / Accessories)
    ├── collection_screen.dart       # Filtered product grid per category with sub-filters
    ├── product_detail_screen.dart   # Hero image, color/size selectors, Add to Cart
    ├── cart_screen.dart             # Cart items, qty controls, order summary, Checkout Now
    ├── checkout_screen.dart         # Shipping address, payment card, order summary, Place Order
    ├── order_confirmation_screen.dart  # Order confirmed, order number, delivery date
    ├── order_history_screen.dart    # Past orders with status badges (DELIVERED / IN TRANSIT)
    ├── reorder_screen.dart          # Review & reorder a past item
    ├── address_screen.dart          # Select / change shipping address (radio selection)
    └── profile_screen.dart          # User info, stats, Order History, Addresses, Logout
```

---

## ✨ Features

| Feature | Detail |
|---|---|
| **UI Fidelity** | Matches all screenshots — lavender/purple palette, Playfair Display + Inter fonts |
| **State Management** | `provider` package — cart persists across tabs via `ChangeNotifier` |
| **Navigation** | Every button navigates to the correct screen |
| **Cart** | Add, remove, increment/decrement quantities; live subtotal calculation |
| **Product Detail** | Animated color swatch selector + size chip selector |
| **Checkout Flow** | Cart → Checkout → Address → Order Confirmation → Back to Shop |
| **Order History** | Reorder and Details buttons; IN TRANSIT / DELIVERED status chips |
| **Auth Flow** | Login → Register → Main app; Logout returns to Login |
| **Responsive** | SafeArea + scrollable layouts for all screen sizes |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_fonts: ^6.1.0        # Playfair Display + Inter typography
  cached_network_image: ^3.3.0 # Efficient network image loading
  provider: ^6.1.2             # Cart state management
```

---

## 🎨 Design Tokens

All colors and typography are centralized in `lib/theme.dart`:

```dart
AppColors.primary       // #3D1F8C — Deep Royal Purple
AppColors.primaryLight  // #6B3FD4 — Gradient accent
AppColors.background    // #F5F0FF — Soft lavender background
AppColors.surface       // #EDE8F8 — Card/chip background
AppColors.price         // #3D1F8C — Price text color
```

---

## 🗺️ App Navigation Flow

```
LoginScreen
    └── RegisterScreen
    └── MainLayout (BottomNav: Home | Shop | Cart | Profile)
            ├── HomeScreen
            │       └── ProductDetailScreen → Add to Cart
            ├── ShopScreen
            │       └── CollectionScreen (Men / Women / Accessories)
            │               └── ProductDetailScreen
            ├── CartScreen
            │       └── CheckoutScreen
            │               ├── AddressScreen (change shipping)
            │               └── OrderConfirmationScreen → MainLayout
            └── ProfileScreen
                    ├── OrderHistoryScreen
                    │       └── ReorderScreen → OrderConfirmationScreen
                    ├── AddressScreen
                    └── Logout → LoginScreen
```

---

## 📝 Notes

- Product images are loaded from **Unsplash** (requires internet connection)
- Mock data is defined in `lib/models/models.dart`
- To add real backend/API, replace mock data with HTTP calls in `cart_provider.dart`
