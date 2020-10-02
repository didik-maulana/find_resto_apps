class ImageAssetHelper {
  static const _basePath = 'assets/images';
  
  static String getImagePath(String imageName) {
    return '$_basePath/$imageName.png';
  }
}