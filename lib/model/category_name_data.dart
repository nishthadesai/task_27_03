class ChooseCategoryData {
  final String image;
  final String name;

  ChooseCategoryData(
    this.image,
    this.name,
  );
}

List categoryList = [
  ChooseCategoryData("assets/images/dairy.png", "Dairy & Eggs"),
  ChooseCategoryData("assets/images/snacks.png", "Snacks"),
  ChooseCategoryData("assets/images/sea_food.png", "Sea Food"),
  ChooseCategoryData("assets/images/frozen_food.png", "Frozen Food"),
  ChooseCategoryData("assets/images/frozen_ice.png", "IceCream"),
];
