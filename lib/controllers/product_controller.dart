import 'package:get/get.dart';
import 'package:news_api/controllers/product_repository.dart';

class ProductController extends GetxController {
  ProductRepository productRepository = ProductRepository();
  RxBool loading = false.obs;
  List products = [].obs;

  ProductController() {
    loadProducsFromRepo();
  }
  loadProducsFromRepo() async {
    loading(true);
    products = await productRepository.loadProductsFromApi();
    loading(false);
  }
}
