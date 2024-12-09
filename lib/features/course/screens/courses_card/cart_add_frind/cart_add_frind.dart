import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leader_app/features/course/controllers/register_controller.dart';
import 'package:leader_app/features/course/screens/courses_card/cart_add_frind/image_full.dart';
import 'package:leader_app/features/user_account/models/user_account_model.dart';
import 'package:leader_app/utils/helpers/helper_functions.dart';
import 'package:leader_app/utils/theme/custom_themes/app_colors.dart';
import '../../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../../utils/constants/sizes.dart';

class CartAddFrind extends StatefulWidget {
  const CartAddFrind({
    super.key,
    required this.peopleList,
    required this.courseId,
  });
  final List<UserAccountModel> peopleList;
  final String courseId;

  @override
  State<CartAddFrind> createState() => _CartAddFrindState();
}

class _CartAddFrindState extends State<CartAddFrind> {
  List<bool> _isButtonClickedList = [];
  List<String> _confirmationOrDeleteList = [];

  @override
  void initState() {
    super.initState();
    _isButtonClickedList = List<bool>.filled(widget.peopleList.length, false);
    _confirmationOrDeleteList = List<String>.filled(widget.peopleList.length, '');
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.peopleList.length,
      separatorBuilder: (_, index) =>
          const SizedBox(height: TSizes.spaceBtwItems / 4),
      itemBuilder: (_, index) => Container(
        color: dark ? TColors.darkerGrey : TColors.grey,
        child: Column(
          children: [
            ///cart Item
            TCartItem(
              imageUrl: widget.peopleList[index].profilePicture ?? '',
              firstName: widget.peopleList[index].firstName,
              lastName: widget.peopleList[index].lastName,
              depatmentName: widget.peopleList[index].depatmentName ?? '',
              userName: widget.peopleList[index].userName,
              universityName: widget.peopleList[index].universityName ?? '',
            ),
            _isButtonClickedList[index]
                ? Text(_confirmationOrDeleteList[index]) // عرض النص بدلاً من الأزرار
                : Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await controller.confirmationRequest(
                              widget.peopleList[index].uid, widget.courseId);
                          await controller.deleteRequest(
                              widget.peopleList[index].uid, widget.courseId);
                          setState(() {
                            _confirmationOrDeleteList[index] = 'I accepted the friend request';
                            _isButtonClickedList[index] = true; // يجعل النص مرئيًا بدلاً من الأزرار
                          });
                        },
                        child: const Text('Confirmation'),
                      ),
                      const SizedBox(width: TSizes.spaceBtwSections),
                      ElevatedButton(
                        onPressed: () {
                          controller.deleteRequest(
                              widget.peopleList[index].uid, widget.courseId);
                          setState(() {
                            _confirmationOrDeleteList[index] = 'I deleted the friend request';
                            _isButtonClickedList[index] = true; // يجعل النص مرئيًا بدلاً من الأزرار
                          });
                        },
                        child: const Text('Delete'),
                      ),
                      const SizedBox(width: TSizes.spaceBtwSections),
                      ElevatedButton(
                        onPressed: () async {
                          String? imageLink = await controller.getImageLink(
                              widget.peopleList[index].uid, widget.courseId);
                          if (imageLink != null) {
                            await Get.to(ImageFullScreenScreen(imageUrl: imageLink));
                          }
                        },
                        child: const Text('Open'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
