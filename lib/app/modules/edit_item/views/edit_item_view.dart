import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jualin/app/themes/colors.dart';
import '../controllers/edit_item_controller.dart';
import 'dart:io';

class EditItemView extends GetView<EditItemController> {
  const EditItemView({super.key});

  @override
  Widget build(BuildContext context) {
    // Ambil data item dari arguments
    final item = Get.arguments['item'];

    // Isi controller dengan data lama
    controller.nameController.text = item['name'] ?? '';
    controller.descriptionController.text = item['description'] ?? '';
    controller.priceController.text = item['price'].toString();
    controller.categoryController.text = item['category'] ?? '';
    controller.imageUrlController.text = item['image_url'] ?? '';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Edit Item',
          style: TextStyle(
            color: AppColors.neutral10,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.neutral10),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Edit the details below.',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    labelText: 'Item Name',
                    labelStyle: TextStyle(color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.neutral10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.neutral10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Description is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    labelStyle: TextStyle(color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.neutral10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Price is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: AppColors.primary),
                    filled: true,
                    fillColor: AppColors.neutral10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Category is required'
                      : null,
                ),
                const SizedBox(height: 16),
                Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Image',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.pickImage(),
                          icon:
                              const Icon(Icons.image, color: AppColors.primary),
                          label: const Text('Choose an Image'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.background,
                            foregroundColor: AppColors.text,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        controller.imageName.value.isNotEmpty
                            ? Text(
                                controller.imageName.value,
                                style: const TextStyle(
                                    fontSize: 14, color: AppColors.text),
                              )
                            : const Text(
                                'No Image Selected',
                                style: TextStyle(
                                    fontSize: 14, color: AppColors.neutral60),
                              ),
                        const SizedBox(height: 8),
                        controller.pickedImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(controller.pickedImage!.path),
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : (controller.imageUrlController.text.isNotEmpty
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      controller.imageUrlController.text,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : const SizedBox()),
                      ],
                    )),
                const SizedBox(height: 24),
                Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.neutral10,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.editItem(item['id']),
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: AppColors.neutral10,
                                strokeWidth: 2.5,
                              ),
                            )
                          : const Text(
                              'Save Changes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
