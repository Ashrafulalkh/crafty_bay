class Urls {
  static const _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const sliderListUrl = '$_baseUrl/ListProductSlider';
  static const categoryListUrl = '$_baseUrl/CategoryList';
  static productListUrl(String remark) => '$_baseUrl/ListProductByRemark/$remark';
  static productListByCategoryUrl(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static productDetailsUrl(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static verifyEmailUrl(String email) => '$_baseUrl/UserLogin/$email';
}