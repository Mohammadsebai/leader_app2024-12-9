import 'package:get/get.dart';
import 'package:leader_app/data/repositorie/news/news_category_repositorie.dart';
import 'package:leader_app/features/news/models/news_model.dart';
import 'package:leader_app/features/personalization/models/university_model.dart';
import 'package:leader_app/utils/loaders/loaders.dart';

class NewsCategoryController extends GetxController {
  static NewsCategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(NewsCategoryRepository());
  // RxList<NewsCategoryModel> allCategories = <NewsCategoryModel>[].obs;
  RxList<NewsPostModel> allPost = <NewsPostModel>[].obs;
  // RxList<NewsCategoryModel> featuredCategories = <NewsCategoryModel>[].obs;

  @override
  void onInit() {
    // fetchCategories();
    //fetchFeaturedProducts();
    fetchAllFeaturedNews();
    super.onInit();
  }

  /// -- Load category data
  Future<void>deleteNews(String newsId) async {
    try {
      isLoading.value = true;
     await _categoryRepository.deleteNews(newsId);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
//Remove Loader
      isLoading.value = false;
    }
  }

  /// -- Load selected category data
  // Future<List<CategoryModel>> getSubCategories(String categoryId) async {
  //   try {
  //     final subCategories =
  //         await _categoryRepository.getSubCategories(categoryId);
  //     return subCategories;
  //   } catch (e) {
  //     TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  //     return [];
  //   }
  // }

  /// Get Category or Sub-Category Products.
//   Future<List<NewsPostModel>> getCategoryNews(
//       {required String categoryId, int limit = 4}) async {
//     try {
// // Fetch limited (4) products against each subCategory;
//       final post = await _categoryRepository.getProductsForCategory(categoryId: categoryId, limit: limit);
//       return post;
//     } catch (e) {
//       TLoaders.errorSnackBar(title: 'Oh snap! ', message: e.toString());
//       return [];
//     }
//   }

//  void fetchFeaturedProducts() async {
//     try {
// // Show loader while loading Products
//       isLoading.value = true;
// // Fetch Products
//       final products = await _categoryRepository.getFeaturedProducts();

// // Assign Products
//       allPost.assignAll(products);

//     } catch (e) {

//       TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }
  Future<List<NewsPostModel>> fetchAllFeaturedNews() 
  async {
    try {
// Fetch Products
      final products = await _categoryRepository.getFeaturedNews();
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }




  Future<UniversityModel?> getUserNews(String id) async {
    try {

// Fetch Products
      final products = await _categoryRepository.getUserNews(id);
      return  products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    return null;
    }
  }



}
