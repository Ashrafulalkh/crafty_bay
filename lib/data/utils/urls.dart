class Urls {
  static const _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const sliderListUrl = '$_baseUrl/ListProductSlider';
  static const categoryListUrl = '$_baseUrl/CategoryList';
  static productListUrl(String category) => '$_baseUrl/ListProductByRemark/$category';
}