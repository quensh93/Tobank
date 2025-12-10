// Example: Creating a Custom Product Card Widget for STAC
// This example demonstrates the complete process of creating a custom STAC widget

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

// Import STAC core (adjust path based on your project structure)
// import 'package:stac/stac.dart';

part 'custom-widget-example.g.dart';

// ============================================================================
// STEP 1: Create the Widget Model
// ============================================================================

/// Model representing a product card with image, title, price, and rating
@JsonSerializable()
class ProductCardModel {
  /// Product image URL
  final String imageUrl;
  
  /// Product title
  final String title;
  
  /// Product description (optional)
  final String? description;
  
  /// Product price
  final double price;
  
  /// Currency symbol (default: $)
  final String currency;
  
  /// Product rating (0-5)
  final double rating;
  
  /// Number of reviews
  final int reviewCount;
  
  /// Whether product is in stock
  final bool inStock;
  
  /// Action to perform when card is tapped (optional)
  final Map<String, dynamic>? onTap;

  const ProductCardModel({
    required this.imageUrl,
    required this.title,
    this.description,
    required this.price,
    this.currency = '\$',
    required this.rating,
    required this.reviewCount,
    this.inStock = true,
    this.onTap,
  });

  /// Create from JSON
  factory ProductCardModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCardModelFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() => _$ProductCardModelToJson(this);
}

// ============================================================================
// STEP 2: Create the Widget Parser
// ============================================================================

/// Parser that converts ProductCardModel to Flutter widget
class ProductCardParser extends StacParser<ProductCardModel> {
  @override
  String get type => 'productCard';

  @override
  ProductCardModel fromJson(Map<String, dynamic> json) {
    return ProductCardModel.fromJson(json);
  }

  @override
  Widget parse(BuildContext context, ProductCardModel model) {
    return ProductCardWidget(model: model);
  }
}

// ============================================================================
// STEP 3: Create the Widget Implementation
// ============================================================================

/// Flutter widget that renders the product card
class ProductCardWidget extends StatelessWidget {
  final ProductCardModel model;

  const ProductCardWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: model.onTap != null
            ? () => _handleTap(context)
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            _buildImage(),
            
            // Product Details
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    model.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  // Description (if provided)
                  if (model.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      model.description!,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  
                  const SizedBox(height: 8),
                  
                  // Rating
                  _buildRating(context),
                  
                  const SizedBox(height: 8),
                  
                  // Price and Stock Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        '${model.currency}${model.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      
                      // Stock Status
                      _buildStockBadge(context),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Image.network(
        model.imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(
              Icons.image_not_supported,
              size: 48,
              color: Colors.grey,
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: Colors.grey[300],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRating(BuildContext context) {
    return Row(
      children: [
        // Star icons
        ...List.generate(5, (index) {
          if (index < model.rating.floor()) {
            return const Icon(Icons.star, size: 16, color: Colors.amber);
          } else if (index < model.rating) {
            return const Icon(Icons.star_half, size: 16, color: Colors.amber);
          } else {
            return const Icon(Icons.star_border, size: 16, color: Colors.amber);
          }
        }),
        
        const SizedBox(width: 4),
        
        // Rating text
        Text(
          '${model.rating.toStringAsFixed(1)} (${model.reviewCount})',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildStockBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: model.inStock ? Colors.green[100] : Colors.red[100],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        model.inStock ? 'In Stock' : 'Out of Stock',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: model.inStock ? Colors.green[900] : Colors.red[900],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    if (model.onTap == null) return;
    
    // Execute the action defined in JSON
    // This would typically use your STAC action system
    // Example: StacActionService.execute(context, model.onTap!);
    
    // For demonstration, just print
    print('Product card tapped: ${model.title}');
  }
}

// ============================================================================
// STEP 4: Register the Parser
// ============================================================================

/// Register the custom widget parser in your app initialization
/// 
/// Example in main.dart:
/// ```dart
/// void main() {
///   // Register custom components
///   final registry = CustomComponentRegistry.instance;
///   registry.registerWidget(ProductCardParser());
///   
///   runApp(MyApp());
/// }
/// ```

// ============================================================================
// STEP 5: Use in JSON
// ============================================================================

/// Example JSON configuration:
/// ```json
/// {
///   "type": "productCard",
///   "imageUrl": "https://example.com/product.jpg",
///   "title": "Premium Wireless Headphones",
///   "description": "High-quality sound with active noise cancellation",
///   "price": 299.99,
///   "currency": "$",
///   "rating": 4.5,
///   "reviewCount": 1234,
///   "inStock": true,
///   "onTap": {
///     "actionType": "navigate",
///     "route": "/product-details",
///     "arguments": {
///       "productId": "12345"
///     }
///   }
/// }
/// ```

// ============================================================================
// STEP 6: Write Tests
// ============================================================================

/// Example unit test:
/// ```dart
/// void main() {
///   group('ProductCardModel', () {
///     test('should serialize to JSON correctly', () {
///       final model = ProductCardModel(
///         imageUrl: 'https://example.com/image.jpg',
///         title: 'Test Product',
///         price: 99.99,
///         rating: 4.5,
///         reviewCount: 100,
///       );
///       
///       final json = model.toJson();
///       
///       expect(json['imageUrl'], 'https://example.com/image.jpg');
///       expect(json['title'], 'Test Product');
///       expect(json['price'], 99.99);
///       expect(json['rating'], 4.5);
///       expect(json['reviewCount'], 100);
///     });
///     
///     test('should deserialize from JSON correctly', () {
///       final json = {
///         'imageUrl': 'https://example.com/image.jpg',
///         'title': 'Test Product',
///         'price': 99.99,
///         'currency': '\$',
///         'rating': 4.5,
///         'reviewCount': 100,
///         'inStock': true,
///       };
///       
///       final model = ProductCardModel.fromJson(json);
///       
///       expect(model.imageUrl, 'https://example.com/image.jpg');
///       expect(model.title, 'Test Product');
///       expect(model.price, 99.99);
///       expect(model.rating, 4.5);
///       expect(model.reviewCount, 100);
///       expect(model.inStock, true);
///     });
///   });
///   
///   group('ProductCardParser', () {
///     testWidgets('should render product card widget', (tester) async {
///       final parser = ProductCardParser();
///       final model = ProductCardModel(
///         imageUrl: 'https://example.com/image.jpg',
///         title: 'Test Product',
///         price: 99.99,
///         rating: 4.5,
///         reviewCount: 100,
///       );
///       
///       await tester.pumpWidget(
///         MaterialApp(
///           home: Scaffold(
///             body: parser.parse(tester.element(find.byType(Scaffold)), model),
///           ),
///         ),
///       );
///       
///       expect(find.text('Test Product'), findsOneWidget);
///       expect(find.text('\$99.99'), findsOneWidget);
///       expect(find.text('4.5 (100)'), findsOneWidget);
///       expect(find.text('In Stock'), findsOneWidget);
///     });
///   });
/// }
/// ```

// ============================================================================
// Notes:
// - Remember to run `dart run build_runner build` after creating the model
// - Test in JSON playground before using in production
// - Add comprehensive error handling for production use
// - Consider adding loading states and error states
// - Document all properties in your team's style guide
// ============================================================================
