class MenuItemModel {
  int id;
  String lable;
  bool? isToggleButtonShow;
  bool? isToggleActive;

  MenuItemModel({
    required this.id,
    required this.lable,
    this.isToggleButtonShow = false,
    this.isToggleActive = false,
  });
}
