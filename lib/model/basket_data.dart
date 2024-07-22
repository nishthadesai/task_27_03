import '../generated/assets.dart';

class BasketData {
  final String image;
  final String title;
  final String subTitle;
  final String address;
  final String away;

  BasketData(
    this.image,
    this.title,
    this.subTitle,
    this.address,
    this.away,
  );
}

List basketItemsData = [
  BasketData(Assets.imagesWalmartLogo3x, "Walmart", "Grocery",
      "3456 Washington Street, Us, 4568", "1 mile"),
  BasketData(Assets.imagesJioMart, "Stop & Shop", "Grocery and general",
      "3456 Washington Street, Us, 4568", "2 mile"),
  BasketData(Assets.imagesFlipKartLogo, "Safeway", "Grocery",
      "3456 Washington Street, Us, 4568", "3.5 mile"),
  BasketData(Assets.imagesWalmartLogo3x, "Giant Food Stores", "Grocery",
      "3456 Washington Street, Us, 4568", "4 mile"),
  BasketData(Assets.imagesJioMart, "Meijer", "Grocery",
      "3456 Washington Street, Us, 4568", "4 mile"),
  BasketData(Assets.imagesFlipKartLogo, "Meijer", "Grocery",
      "3456 Washington Street, Us, 4568", "4 mile"),
];
