import 'package:flutter_grocery_store/model/category_model.dart';

import '../../model/product_model.dart';

abstract class DummyDb {
  static List<CategoryModel> groceryCategories = [
    CategoryModel(
      id: 1,
      name: 'Fruits',
      imageUrl:
          'https://freepngimg.com/thumb/fruit/4-2-fruit-png-image-thumb.png',
    ),
    CategoryModel(
      id: 2,
      name: 'Vegetables',
      imageUrl:
          'https://static.vecteezy.com/system/resources/thumbnails/022/984/730/small_2x/vegetable-transparent-free-png.png',
    ),
    CategoryModel(
      id: 3,
      name: 'Dairy',
      imageUrl:
          'https://img.pikbest.com/origin/09/10/23/83mpIkbEsTeNM.png!sw800',
    ),
    CategoryModel(
      id: 4,
      name: 'Bakery',
      imageUrl:
          'https://www.nicepng.com/png/full/289-2897370_bakery-items-png.png',
    ),
    CategoryModel(
      id: 5,
      name: 'Meat',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/032/325/229/original/raw-chicken-meat-isolated-on-transparent-background-file-cut-out-ai-generated-png.png',
    ),
    CategoryModel(
      id: 6,
      name: 'Seafood',
      imageUrl:
          'https://static.vecteezy.com/system/resources/previews/022/984/294/original/steamed-fish-transparent-free-png.png',
    ),
    CategoryModel(
      id: 7,
      name: 'Canned Goods',
      imageUrl:
          'https://static.wikia.nocookie.net/last-day-on-earth-survival/images/c/c3/Canned_Food.png/revision/latest/thumbnail/width/360/height/450?cb=20190824175453',
    ),
    CategoryModel(
      id: 8,
      name: 'Grains',
      imageUrl:
          'https://freepngimg.com/save/53730-grain-hd-download-free-image/500x306',
    ),
    CategoryModel(
      id: 9,
      name: 'Beverages',
      imageUrl:
          'https://i.pinimg.com/originals/bb/1d/37/bb1d37ad9822cda7018f5fe02bc2f60f.png',
    ),
    CategoryModel(
      id: 10,
      name: 'Snacks',
      imageUrl: 'https://clipground.com/images/snacks-png-2.png',
    ),
  ];

  static List<ProductModel> groceryItems = [
    ProductModel(
      id: 1,
      name: 'Apple',
      description: 'Fresh and delicious apple',
      imageUrl:
          'https://static.vecteezy.com/system/resources/thumbnails/023/290/773/small/fresh-red-apple-isolated-on-transparent-background-generative-ai-png.png',
      price: 1.99,
      rating: 4.5,
      ratingCount: 100,
      barcode: '1234567890',
    ),
    ProductModel(
      id: 2,
      name: 'Banana',
      description: 'Ripe and sweet banana',
      imageUrl:
          'https://png.pngtree.com/png-clipart/20220716/ourmid/pngtree-banana-yellow-fruit-banana-skewers-png-image_5944324.png',
      price: 0.99,
      rating: 4.3,
      ratingCount: 80,
      barcode: '0987654321',
    ),
    ProductModel(
      id: 3,
      name: 'Carrot',
      description: 'Crunchy and nutritious carrot',
      imageUrl:
          'https://wallpapers.com/images/featured/carrot-png-7crm54jnhoaaa46f.jpg',
      price: 0.49,
      rating: 4.2,
      ratingCount: 60,
      barcode: '1357924680',
    ),
    ProductModel(
      id: 4,
      name: 'Milk',
      description: 'Fresh dairy milk',
      imageUrl:
          'https://purepng.com/public/uploads/large/purepng.com-milkmilkliquidnutritioncow-1411527957210irmnt.png',
      price: 2.49,
      rating: 4.6,
      ratingCount: 120,
      barcode: '2468013579',
    ),
    ProductModel(
      id: 5,
      name: 'Bread',
      description: 'Soft and fluffy bread loaf',
      imageUrl:
          'https://lh3.googleusercontent.com/proxy/PNXey313AC6G1YaBR4K1r1otuOTpp59tngHn3jGiuFCsz0PVmBBSQQRp0w2fJnHeg3F3xNtW3tLyNdR3frJcqJRq3EuDNwGhY3n7frY4b7WAUhNDHEPKMg',
      price: 1.79,
      rating: 4.7,
      ratingCount: 150,
      barcode: '9876543210',
    ),
    ProductModel(
      id: 6,
      name: 'Eggs',
      description: 'Farm-fresh eggs',
      imageUrl: '',
      price: 2.99,
      rating: 4.8,
      ratingCount: 200,
      barcode: '0123456789',
    ),
    // Add more grocery items below
    ProductModel(
      id: 7,
      name: 'Orange',
      description: 'Juicy orange',
      imageUrl: '',
      price: 1.29,
      rating: 4.4,
      ratingCount: 90,
      barcode: '0987654322',
    ),
    ProductModel(
      id: 8,
      name: 'Potato',
      description: 'Versatile potato',
      imageUrl: '',
      price: 0.69,
      rating: 4.1,
      ratingCount: 70,
      barcode: '1357924681',
    ),
    ProductModel(
      id: 9,
      name: 'Cheese',
      description: 'Creamy cheese',
      imageUrl: '',
      price: 3.99,
      rating: 4.9,
      ratingCount: 180,
      barcode: '2468013578',
    ),
    ProductModel(
      id: 10,
      name: 'Butter',
      description: 'Rich butter',
      imageUrl: '',
      price: 2.29,
      rating: 4.6,
      ratingCount: 130,
      barcode: '1234567891',
    ),
    ProductModel(
      id: 11,
      name: 'Chicken Breast',
      description: 'Lean chicken breast',
      imageUrl: '',
      price: 5.49,
      rating: 4.5,
      ratingCount: 120,
      barcode: '9876543211',
    ),
    ProductModel(
      id: 12,
      name: 'Salmon Fillet',
      description: 'Fresh salmon fillet',
      imageUrl: '',
      price: 8.99,
      rating: 4.8,
      ratingCount: 250,
      barcode: '0123456788',
    ),
    // Add more grocery items as needed
    ProductModel(
      id: 13,
      name: 'Spinach',
      description: 'Nutritious spinach',
      imageUrl: '',
      price: 1.49,
      rating: 4.3,
      ratingCount: 100,
      barcode: '1357924682',
    ),
    ProductModel(
      id: 14,
      name: 'Yogurt',
      description: 'Creamy yogurt',
      imageUrl: '',
      price: 1.99,
      rating: 4.7,
      ratingCount: 150,
      barcode: '2468013577',
    ),
    ProductModel(
      id: 15,
      name: 'Tomato',
      description: 'Fresh tomato',
      imageUrl: '',
      price: 0.79,
      rating: 4.2,
      ratingCount: 80,
      barcode: '1234567892',
    ),
    ProductModel(
      id: 16,
      name: 'Onion',
      description: 'Versatile onion',
      imageUrl: '',
      price: 0.59,
      rating: 4.0,
      ratingCount: 70,
      barcode: '0987654323',
    ),
    ProductModel(
      id: 17,
      name: 'Orange Juice',
      description: 'Refreshing orange juice',
      imageUrl: '',
      price: 2.99,
      rating: 4.5,
      ratingCount: 130,
      barcode: '1357924683',
    ),
    ProductModel(
      id: 18,
      name: 'Pasta',
      description: 'Delicious pasta',
      imageUrl: '',
      price: 1.19,
      rating: 4.4,
      ratingCount: 90,
      barcode: '2468013576',
    ),
    ProductModel(
      id: 19,
      name: 'Rice',
      description: 'Nutritious rice',
      imageUrl: '',
      price: 2.79,
      rating: 4.6,
      ratingCount: 160,
      barcode: '1234567893',
    ),
    ProductModel(
      id: 20,
      name: 'Coffee',
      description: 'Rich coffee beans',
      imageUrl: '',
      price: 4.49,
      rating: 4.8,
      ratingCount: 200,
      barcode: '0987654324',
    ),
    ProductModel(
      id: 21,
      name: 'Tea',
      description: 'Aromatic tea leaves',
      imageUrl: '',
      price: 3.29,
      rating: 4.7,
      ratingCount: 180,
      barcode: '1357924684',
    ),
    ProductModel(
      id: 22,
      name: 'Cereal',
      description: 'Crunchy cereal',
      imageUrl: '',
      price: 3.99,
      rating: 4.5,
      ratingCount: 150,
      barcode: '2468013575',
    ),
    ProductModel(
      id: 23,
      name: 'Orange Pepper',
      description: 'Colorful orange pepper',
      imageUrl: '',
      price: 1.29,
      rating: 4.3,
      ratingCount: 100,
      barcode: '1234567894',
    ),
    ProductModel(
      id: 24,
      name: 'Lemon',
      description: 'Zesty lemon',
      imageUrl: '',
      price: 0.89,
      rating: 4.2,
      ratingCount: 80,
      barcode: '0987654325',
    ),
    ProductModel(
      id: 25,
      name: 'Pineapple',
      description: 'Sweet pineapple',
      imageUrl: '',
      price: 3.99,
      rating: 4.6,
      ratingCount: 160,
      barcode: '1357924685',
    ),
    ProductModel(
      id: 26,
      name: 'Avocado',
      description: 'Creamy avocado',
      imageUrl: '',
      price: 1.99,
      rating: 4.7,
      ratingCount: 130,
      barcode: '2468013574',
    ),
    ProductModel(
      id: 27,
      name: 'Strawberry',
      description: 'Juicy strawberry',
      imageUrl: '',
      price: 2.49,
      rating: 4.5,
      ratingCount: 110,
      barcode: '1234567895',
    ),
    ProductModel(
      id: 28,
      name: 'Cucumber',
      description: 'Crisp cucumber',
      imageUrl: '',
      price: 0.79,
      rating: 4.4,
      ratingCount: 90,
      barcode: '0987654326',
    ),
    ProductModel(
      id: 29,
      name: 'Salad Dressing',
      description: 'Tasty salad dressing',
      imageUrl: '',
      price: 2.29,
      rating: 4.6,
      ratingCount: 140,
      barcode: '1357924686',
    ),
    ProductModel(
      id: 30,
      name: 'Bell Pepper',
      description: 'Colorful bell pepper',
      imageUrl: '',
      price: 1.49,
      rating: 4.3,
      ratingCount: 100,
      barcode: '2468013573',
    ),
    ProductModel(
      id: 31,
      name: 'Blueberry',
      description: 'Sweet blueberry',
      imageUrl: '',
      price: 3.99,
      rating: 4.8,
      ratingCount: 170,
      barcode: '1234567896',
    ),
    ProductModel(
      id: 32,
      name: 'Watermelon',
      description: 'Juicy watermelon',
      imageUrl: '',
      price: 5.99,
      rating: 4.9,
      ratingCount: 220,
      barcode: '0987654327',
    ),
    ProductModel(
      id: 33,
      name: 'Grapes',
      description: 'Sweet grapes',
      imageUrl: '',
      price: 2.99,
      rating: 4.7,
      ratingCount: 120,
      barcode: '1357924687',
    ),
    ProductModel(
      id: 34,
      name: 'Broccoli',
      description: 'Nutritious broccoli',
      imageUrl: '',
      price: 1.99,
      rating: 4.4,
      ratingCount: 90,
      barcode: '2468013572',
    ),
    ProductModel(
      id: 35,
      name: 'Zucchini',
      description: 'Versatile zucchini',
      imageUrl: '',
      price: 1.29,
      rating: 4.1,
      ratingCount: 70,
      barcode: '1234567897',
    ),
    ProductModel(
      id: 36,
      name: 'Lettuce',
      description: 'Crisp lettuce',
      imageUrl: '',
      price: 1.79,
      rating: 4.5,
      ratingCount: 110,
      barcode: '0987654328',
    ),
    ProductModel(
      id: 37,
      name: 'Cherry',
      description: 'Sweet cherry',
      imageUrl: '',
      price: 3.99,
      rating: 4.6,
      ratingCount: 140,
      barcode: '1357924688',
    ),
    ProductModel(
      id: 38,
      name: 'Cabbage',
      description: 'Fresh cabbage',
      imageUrl: '',
      price: 1.49,
      rating: 4.3,
      ratingCount: 100,
      barcode: '2468013571',
    ),
    ProductModel(
      id: 39,
      name: 'Asparagus',
      description: 'Tender asparagus',
      imageUrl: '',
      price: 2.99,
      rating: 4.7,
      ratingCount: 130,
      barcode: '1234567898',
    ),
    ProductModel(
      id: 40,
      name: 'Celery',
      description: 'Crunchy celery',
      imageUrl: '',
      price: 0.99,
      rating: 4.2,
      ratingCount: 80,
      barcode: '0987654329',
    ),
    ProductModel(
      id: 41,
      name: 'Kiwi',
      description: 'Exotic kiwi',
      imageUrl: '',
      price: 1.99,
      rating: 4.5,
      ratingCount: 110,
      barcode: '1357924689',
    ),
    ProductModel(
      id: 42,
      name: 'Mango',
      description: 'Sweet mango',
      imageUrl: '',
      price: 2.99,
      rating: 4.7,
      ratingCount: 140,
      barcode: '2468013570',
    ),
    ProductModel(
      id: 43,
      name: 'Pear',
      description: 'Juicy pear',
      imageUrl: '',
      price: 1.79,
      rating: 4.4,
      ratingCount: 90,
      barcode: '1234567899',
    ),
    ProductModel(
      id: 44,
      name: 'Peach',
      description: 'Ripe peach',
      imageUrl: '',
      price: 1.99,
      rating: 4.5,
      ratingCount: 100,
      barcode: '0987654320',
    ),
    ProductModel(
      id: 45,
      name: 'Plum',
      description: 'Sweet plum',
      imageUrl: '',
      price: 1.49,
      rating: 4.3,
      ratingCount: 80,
      barcode: '1357924680',
    ),
    ProductModel(
      id: 46,
      name: 'Pomegranate',
      description: 'Tangy pomegranate',
      imageUrl: '',
      price: 2.99,
      rating: 4.6,
      ratingCount: 120,
      barcode: '2468013579',
    ),
    ProductModel(
      id: 47,
      name: 'Raspberry',
      description: 'Juicy raspberry',
      imageUrl: '',
      price: 3.99,
      rating: 4.8,
      ratingCount: 150,
      barcode: '1234567891',
    ),
    ProductModel(
      id: 48,
      name: 'Brussels Sprout',
      description: 'Nutritious Brussels sprout',
      imageUrl: '',
      price: 1.99,
      rating: 4.4,
      ratingCount: 100,
      barcode: '0987654321',
    ),
    ProductModel(
      id: 49,
      name: 'Cauliflower',
      description: 'Versatile cauliflower',
      imageUrl: '',
      price: 1.79,
      rating: 4.3,
      ratingCount: 90,
      barcode: '1357924681',
    ),
    ProductModel(
      id: 50,
      name: 'Cantaloupe',
      description: 'Sweet cantaloupe',
      imageUrl: '',
      price: 2.99,
      rating: 4.6,
      ratingCount: 120,
      barcode: '2468013578',
    ),
  ];
}
