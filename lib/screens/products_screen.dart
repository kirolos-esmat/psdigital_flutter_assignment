import 'package:flutter/material.dart';
import '../models/restaurant_item.dart';
import '../services/api_service.dart';
import '../widgets/category_list.dart';
import '../widgets/food_item_card.dart';

void showTopBanner(
  BuildContext context,
  String message, {
  Color color = Colors.orange,
  Duration duration = const Duration(seconds: 2),
}) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentMaterialBanner();
  final banner = MaterialBanner(
    backgroundColor: color,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    content: Text(
      message,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
    ),
    actions: [
      TextButton(
        onPressed: () => messenger.hideCurrentMaterialBanner(),
        child: const Text('CLOSE', style: TextStyle(color: Colors.white)),
      ),
    ],
  );
  messenger.showMaterialBanner(banner);
  Future.delayed(duration, () {
    if (messenger.mounted) messenger.hideCurrentMaterialBanner();
  });
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<RestaurantItem> items = [];
  List<RestaurantItem> filteredItems = [];
  bool isLoading = true;
  String selectedCategory = 'Sandwiches';
  int cartItemCount = 12;
  double totalCartPrice = 333.0;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  List<RestaurantItem> getFigmaSandwiches() {
    final sandwiches = [
      RestaurantItem(
        itemID: 9001,
        itemName: 'Crunchy Jalapeno Sandwich',
        itemDescription: 'Spicy sandwich prepared with 10 crunch and Kris',
        itemPrice: 170.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9002,
        itemName: 'Tex Supreme Sandwich',
        itemDescription: 'Spicy sandwich prepared with 10 crunch and Kris',
        itemPrice: 170.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9003,
        itemName: 'Classic Sandwich',
        itemDescription: 'Sandwich prepared with 10 crunch and Kris',
        itemPrice: 170.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1594212699903-ec8a3eca50f5?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9004,
        itemName: 'BBQ Chicken Sandwich',
        itemDescription: 'Grilled chicken with BBQ sauce and crispy lettuce',
        itemPrice: 180.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9005,
        itemName: 'Spicy Buffalo Sandwich',
        itemDescription: 'Hot buffalo chicken with ranch dressing',
        itemPrice: 185.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1520072959219-c595dc870360?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9006,
        itemName: 'Cheese Deluxe Sandwich',
        itemDescription: 'Double cheese with grilled chicken and vegetables',
        itemPrice: 190.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9007,
        itemName: 'Crispy Chicken Sandwich',
        itemDescription: 'Crispy fried chicken with mayo and pickles',
        itemPrice: 175.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9008,
        itemName: 'Mushroom Swiss Sandwich',
        itemDescription: 'Grilled mushrooms with swiss cheese and herbs',
        itemPrice: 195.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1550317138-10000687a72b?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9009,
        itemName: 'Bacon Ranch Sandwich',
        itemDescription: 'Crispy bacon with ranch sauce and fresh lettuce',
        itemPrice: 200.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9010,
        itemName: 'Teriyaki Chicken Sandwich',
        itemDescription: 'Grilled chicken with teriyaki glaze and pineapple',
        itemPrice: 185.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1561758033-d89a9ad46330?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9011,
        itemName: 'Avocado Club Sandwich',
        itemDescription: 'Fresh avocado with grilled chicken and tomatoes',
        itemPrice: 210.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1603064752734-4c48eff53d05?w=300&h=200&fit=crop',
      ),
      RestaurantItem(
        itemID: 9012,
        itemName: 'Smoky Chipotle Sandwich',
        itemDescription:
            'Smoky chipotle sauce with grilled chicken and peppers',
        itemPrice: 195.0,
        restaurantName: 'Texas Chicken',
        restaurantID: 1,
        imageUrl:
            'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300&h=200&fit=crop',
      ),
    ];
    return sandwiches;
  }

  Future<void> loadItems() async {
    try {
      setState(() {
        isLoading = true;
      });

      final figmaSandwiches = getFigmaSandwiches();

      setState(() {
        items = figmaSandwiches;
        filterItemsByCategory(selectedCategory);
        isLoading = false;
      });

      try {
        final loadedItems = await ApiService.getRestaurantItems();
        setState(() {
          items = [...figmaSandwiches, ...loadedItems];
          filterItemsByCategory(selectedCategory);
        });
      } catch (apiError) {
        if (mounted) {
          showTopBanner(context, 'API unavailable, showing local items');
        }
      }
    } catch (e) {
      setState(() {
        items = getFigmaSandwiches();
        filterItemsByCategory(selectedCategory);
        isLoading = false;
      });
    }
  }

  void filterItemsByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (items.length > 12) {
        debugPrint('Total items available: ${items.length}');
      }

      switch (category.toLowerCase()) {
        case 'sandwiches':
          final figmaSandwiches = items
              .where((item) => item.itemID >= 9000)
              .toList();
          final apiSandwiches = items
              .where(
                (item) =>
                    item.itemID < 9000 &&
                    (item.itemName.toLowerCase().contains('sandwich') ||
                        item.itemDescription.toLowerCase().contains(
                          'sandwich',
                        )),
              )
              .toList();
          filteredItems = [...figmaSandwiches, ...apiSandwiches];
          break;
        case 'limited time offers':
          filteredItems = items.where((item) => item.itemPrice > 400).toList();
          break;
        case 'star box':
          filteredItems = items
              .where(
                (item) =>
                    item.itemName.toLowerCase().contains('biryani') ||
                    item.itemName.toLowerCase().contains('kebab'),
              )
              .toList();
          break;
        case 'drinks':
          filteredItems = items
              .where(
                (item) =>
                    item.itemName.toLowerCase().contains('coffee') ||
                    item.itemName.toLowerCase().contains('lassi') ||
                    item.itemName.toLowerCase().contains('brew'),
              )
              .toList();
          break;
        case 'desserts':
          filteredItems = items
              .where(
                (item) =>
                    item.itemName.toLowerCase().contains('gulab') ||
                    item.itemName.toLowerCase().contains('kulfi') ||
                    item.itemName.toLowerCase().contains('meetha') ||
                    item.itemName.toLowerCase().contains('cake') ||
                    item.itemName.toLowerCase().contains('sweet'),
              )
              .toList();
          break;
        default:
          filteredItems = items;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'EXPLORE MENU',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // Handle search
            },
            icon: const Icon(Icons.search, color: Colors.black, size: 28),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          CategoryList(onCategorySelected: filterItemsByCategory),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  selectedCategory,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${filteredItems.length} Items)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    ),
                  )
                : filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No items found in this category',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: loadItems,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    color: Colors.orange,
                    onRefresh: loadItems,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 2.1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return FoodItemCard(
                          item: filteredItems[index],
                          onFavoritePressed: () {
                            // Handle favorite
                          },
                          onCustomizePressed: () {
                            showTopBanner(
                              context,
                              'Customize feature coming soon!',
                            );
                          },
                          onAddToCart: () {
                            setState(() {
                              cartItemCount++;
                              totalCartPrice += filteredItems[index].itemPrice;
                            });
                          },
                          onRemoveFromCart: () {
                            if (cartItemCount > 0) {
                              setState(() {
                                cartItemCount--;
                                totalCartPrice -=
                                    filteredItems[index].itemPrice;
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
