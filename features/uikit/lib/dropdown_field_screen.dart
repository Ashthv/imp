import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/dropdown/dropdown_field.dart';
import 'package:tcs_dff_design_system/utils/dropdown_menue_model.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class DropdownFieldScreen extends StatelessWidget {
  const DropdownFieldScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final dropdown1 = TextEditingController();
    final dropdown2 = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.size25.dp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: DropdownField(
              bottomContent: Container(
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Expanded(
                        child: TextWidget(
                          text: 'Search your employer instead',
                          style: context.theme.appTextStyles.labelSmall16Medium
                              .copyWith(
                            color: Colors.white,
                            fontSize: size.size12.sp,
                            fontWeight: FontWeight.w200,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      ImageWidget(
                        imageType: ImageType.assetImage,
                        path: 'packages/shared/lib/assets/images/search.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                ),
              ),
              dropdownFieldController: dropdown1,
              title: 'City',
              searchFieldHint: 'Search',
              dropdownMenuList: [
                DropdownMenuModel(
                  title: 'Mumbai',
                ),
                DropdownMenuModel(
                  title: 'Pune',
                ),
                DropdownMenuModel(
                  title: 'Chennai',
                ),
              ],
              selectedIndex: 2,
              lableHeight: 0.5.dp,
              onOptionSelect: (final p0) {},
            ),
          ),
          Flexible(
            child: DropdownField(
              dropdownFieldController: dropdown2,
              title: 'Dropdown with scroll',
              searchFieldHint: 'Search',
              dropdownMenuList: [
                DropdownMenuModel(
                  title: 'Mumbai',
                ),
                DropdownMenuModel(
                  title: 'Pune',
                ),
                DropdownMenuModel(
                  title: 'Chennai',
                ),
                DropdownMenuModel(
                  title: 'Uttar Pradesh',
                ),
                DropdownMenuModel(
                  title: 'Hydrabad',
                ),
                DropdownMenuModel(
                  title: 'Delhi',
                ),
                DropdownMenuModel(
                  title: 'Belgaon',
                ),
                DropdownMenuModel(
                  title: 'Lucknow',
                ),
                DropdownMenuModel(
                  title: 'Deharadun',
                ),
              ],
              onOptionSelect: (final p0) {},
            ),
          ),
          Flexible(
            child: DropdownField(
              title: 'Dropdown with searchBar',
              bottomSheetTitle: 'Search Bar',
              searchFieldHint: 'Search',
              isSearchEnabled: true,
              dropdownMenuList: [
                DropdownMenuModel(
                  title: 'Mumbai',
                ),
                DropdownMenuModel(
                  title: 'Pune',
                ),
                DropdownMenuModel(
                  title: 'Chennai',
                ),
                DropdownMenuModel(
                  title: 'Uttar Pradesh',
                ),
                DropdownMenuModel(
                  title: 'Hydrabad',
                ),
                DropdownMenuModel(
                  title: 'Delhi',
                ),
                DropdownMenuModel(
                  title: 'Belgaon',
                ),
                DropdownMenuModel(
                  title: 'Lucknow',
                ),
                DropdownMenuModel(
                  title: 'Deharadun',
                ),
              ],
              onOptionSelect: (final p0) {},
            ),
          ),
          Flexible(
            child: DropdownField(
              title: 'Dropdown with image',
              searchFieldHint: 'Search',
              dropdownMenuList: [
                DropdownMenuModel(
                  title: 'Mumbai',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
                DropdownMenuModel(
                  title: 'Pune',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
                DropdownMenuModel(
                  title: 'Chennai',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
                DropdownMenuModel(
                  title: 'Uttar Pradesh',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
                DropdownMenuModel(
                  title: 'Hydrabad',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
                DropdownMenuModel(
                  title: 'Delhi',
                  imagePath: 'images/coins.png',
                  imagePackage: 'uikit',
                ),
              ],
              onOptionSelect: (final p0) {},
            ),
          ),
          Flexible(
            child: DropdownField(
              currentLocation: 'Delhi',
              title: 'Dropdown with description',
              locationFieldTitle: 'Based On Your Location',
              allOptionTitle: 'All Options',
              dropdownMenuList: [
                DropdownMenuModel(
                  title: 'Mumbai',
                  subtitle: 'Maharashtra',
                ),
                DropdownMenuModel(
                  title: 'Pune',
                  subtitle: 'Maharashtra',
                ),
                DropdownMenuModel(
                  title: 'Chennai',
                  subtitle: 'Tamilnadu',
                ),
                DropdownMenuModel(
                  title: 'Hydrabad',
                  subtitle: 'Telangana',
                ),
              ],
              onOptionSelect: (final p0) {},
            ),
          ),
        ],
      ),
    );
  }
}
