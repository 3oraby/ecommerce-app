import 'package:e_commerce_app/core/models/product_model.dart';
import 'package:e_commerce_app/core/utils/styles/text_styles.dart';
import 'package:e_commerce_app/core/utils/theme/colors.dart';
import 'package:flutter/material.dart';

void showCartSuccessModal(BuildContext context, ProductModel productModel) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ThemeColors.successfullyDoneColor,
                      borderRadius: BorderRadius.circular(200),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.done_outlined,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.name,
                        style: TextStyles.aDLaMDisplayBlackBold22,
                      ),
                      const Text(
                        "Added to cart",
                        style: TextStyle(
                          color: ThemeColors.successfullyDoneColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                color: ThemeColors.backgroundBodiesColor,
                height: 30,
                width: double.infinity,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Continue Shopping"),
                    Text("Go to Cart"),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
