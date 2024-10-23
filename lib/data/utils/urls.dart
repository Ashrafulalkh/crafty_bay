class Urls {
  static const _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  static const sliderListUrl = '$_baseUrl/ListProductSlider';
  static const categoryListUrl = '$_baseUrl/CategoryList';
  static const readProfileDetailsUrl = '$_baseUrl/ReadProfile';
  static const addToCartUrl = '$_baseUrl/CreateCartList';
  static const completeProfileUrl = '$_baseUrl/CreateProfile';
  static const createReviewUrl = '$_baseUrl/CreateProductReview';

  static productListUrl(String remark) => '$_baseUrl/ListProductByRemark/$remark';
  static productListByCategoryUrl(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static productDetailsUrl(int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static verifyEmailUrl(String email) => '$_baseUrl/UserLogin/$email';
  static verifyOtpUrl(String email, String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static reviewUrl(int id) => '$_baseUrl/ListReviewByProduct/$id';
}