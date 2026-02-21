// =============================================================================
// Mock Product Data - In-memory product catalog
// =============================================================================
// Simulates a backend data source with realistic product data.
// In production, this would be replaced by an API client.
// =============================================================================

import 'package:state_bloc_tutorial/models/models.dart';

// ---------------------------------------------------------------------------
// Mock product catalog
// ---------------------------------------------------------------------------

/// Static mock data representing the product catalog.
///
/// Contains 15 products across 5 categories for demonstration purposes.
/// Each product has a placeholder image URL using picsum.photos.
final List<Product> mockProducts = [
  // --- Electronics ---
  const Product(
    id: 'elec-001',
    name: 'Wireless Headphones',
    price: 79.99,
    category: ProductCategory.electronics,
    description:
        'Premium noise-cancelling wireless headphones with 30-hour battery life. '
        'Features Bluetooth 5.0 and built-in microphone for calls.',
    imageUrl: 'https://picsum.photos/seed/headphones/200',
  ),
  const Product(
    id: 'elec-002',
    name: 'Smart Watch',
    price: 249.99,
    category: ProductCategory.electronics,
    description:
        'Feature-rich smartwatch with heart rate monitor, GPS tracking, '
        'and water resistance up to 50 meters.',
    imageUrl: 'https://picsum.photos/seed/smartwatch/200',
  ),
  const Product(
    id: 'elec-003',
    name: 'Portable Charger',
    price: 34.99,
    category: ProductCategory.electronics,
    description:
        '20000mAh portable power bank with fast charging support. '
        'Charges up to 3 devices simultaneously.',
    imageUrl: 'https://picsum.photos/seed/charger/200',
  ),

  // --- Clothing ---
  const Product(
    id: 'cloth-001',
    name: 'Cotton T-Shirt',
    price: 24.99,
    category: ProductCategory.clothing,
    description:
        '100% organic cotton crew neck t-shirt. Available in multiple colors. '
        'Pre-shrunk and machine washable.',
    imageUrl: 'https://picsum.photos/seed/tshirt/200',
  ),
  const Product(
    id: 'cloth-002',
    name: 'Denim Jacket',
    price: 89.99,
    category: ProductCategory.clothing,
    description:
        'Classic denim jacket with a modern slim fit. Features button closure '
        'and two chest pockets.',
    imageUrl: 'https://picsum.photos/seed/jacket/200',
  ),
  const Product(
    id: 'cloth-003',
    name: 'Running Sneakers',
    price: 129.99,
    category: ProductCategory.clothing,
    description:
        'Lightweight running shoes with responsive cushioning and breathable '
        'mesh upper for maximum comfort.',
    imageUrl: 'https://picsum.photos/seed/sneakers/200',
  ),

  // --- Books ---
  const Product(
    id: 'book-001',
    name: 'Flutter in Action',
    price: 39.99,
    category: ProductCategory.books,
    description:
        'Comprehensive guide to building cross-platform apps with Flutter. '
        'Covers widgets, state management, and testing.',
    imageUrl: 'https://picsum.photos/seed/flutterbook/200',
  ),
  const Product(
    id: 'book-002',
    name: 'Clean Architecture',
    price: 44.99,
    category: ProductCategory.books,
    description:
        'A guide to software structure and design principles. Learn how to '
        'build maintainable and testable applications.',
    imageUrl: 'https://picsum.photos/seed/cleanarch/200',
  ),
  const Product(
    id: 'book-003',
    name: 'Design Patterns',
    price: 49.99,
    category: ProductCategory.books,
    description:
        'Classic reference on software design patterns. Covers creational, '
        'structural, and behavioral patterns.',
    imageUrl: 'https://picsum.photos/seed/patterns/200',
  ),

  // --- Home ---
  const Product(
    id: 'home-001',
    name: 'Ceramic Mug Set',
    price: 29.99,
    category: ProductCategory.home,
    description:
        'Set of 4 handcrafted ceramic mugs. Microwave and dishwasher safe. '
        'Each holds 12 oz.',
    imageUrl: 'https://picsum.photos/seed/mugs/200',
  ),
  const Product(
    id: 'home-002',
    name: 'Throw Blanket',
    price: 54.99,
    category: ProductCategory.home,
    description:
        'Ultra-soft sherpa throw blanket. Perfect for cozy evenings. '
        'Machine washable, 50x60 inches.',
    imageUrl: 'https://picsum.photos/seed/blanket/200',
  ),
  const Product(
    id: 'home-003',
    name: 'LED Desk Lamp',
    price: 42.99,
    category: ProductCategory.home,
    description:
        'Adjustable LED desk lamp with 5 brightness levels and 3 color modes. '
        'USB charging port included.',
    imageUrl: 'https://picsum.photos/seed/desklamp/200',
  ),

  // --- Sports ---
  const Product(
    id: 'sport-001',
    name: 'Yoga Mat',
    price: 35.99,
    category: ProductCategory.sports,
    description:
        'Non-slip yoga mat with alignment lines. 6mm thick for joint comfort. '
        'Includes carrying strap.',
    imageUrl: 'https://picsum.photos/seed/yogamat/200',
  ),
  const Product(
    id: 'sport-002',
    name: 'Resistance Bands Set',
    price: 19.99,
    category: ProductCategory.sports,
    description:
        'Set of 5 resistance bands with varying tension levels. Includes '
        'door anchor and carrying bag.',
    imageUrl: 'https://picsum.photos/seed/bands/200',
  ),
  const Product(
    id: 'sport-003',
    name: 'Water Bottle',
    price: 22.99,
    category: ProductCategory.sports,
    description:
        'Insulated stainless steel water bottle. Keeps drinks cold for 24 hours '
        'or hot for 12 hours. BPA-free, 32 oz.',
    imageUrl: 'https://picsum.photos/seed/bottle/200',
  ),
];
