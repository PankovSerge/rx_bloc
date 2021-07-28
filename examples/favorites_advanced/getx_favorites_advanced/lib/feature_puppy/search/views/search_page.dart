import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:favorites_advanced_base/core.dart';
import 'package:favorites_advanced_base/resources.dart';
import 'package:getx_favorites_advanced/base/routes/app_pages.dart';

import 'package:getx_favorites_advanced/feature_puppy/controllers/puppy_extra_details_controller.dart';
import 'package:getx_favorites_advanced/feature_puppy/search/controllers/puppy_list_controller.dart';
import 'package:getx_favorites_advanced/feature_puppy/controllers/puppy_manage_controller.dart';

class SearchPage extends GetView<PuppyListController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: controller.obx(
          (puppies) => RefreshIndicator(
            onRefresh: () async {
              await controller.onRefresh();
            },
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 67),
              itemCount: puppies!.length,
              itemBuilder: (context, index) => Obx(
                () {
                  final item = puppies[index];
                  return PuppyCard(
                    key: Key('${Keys.puppyCardNamePrefix}${item.id}'),
                    puppy: item,
                    onVisible: (item) => Get.find<PuppyExtraDetailsController>()
                        .fetchExtraDetails(item),
                    onCardPressed: (item) =>
                        Get.toNamed(AppPages.details, arguments: item),
                    onFavorite: (item, isFavorite) {
                      Get.find<PuppyManageController>()
                          .markAsFavorite(puppy: item, isFavorite: isFavorite);
                    },
                  );
                },
              ),
            ),
          ),
          onError: (error) => ErrorRetryWidget(
            onReloadTap: () => controller.onReload(),
          ),
          onEmpty: Container(),
        ),
      );
}
