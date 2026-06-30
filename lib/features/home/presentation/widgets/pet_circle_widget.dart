
import 'package:flutter/material.dart';
import 'package:rifq_v2/core/theme/app_theme.dart';

class PetCircleWidget extends StatelessWidget {
  final String? imageUrl;
  final String? petName;
  final bool isEmpty;
  final VoidCallback? onAdd;

  const PetCircleWidget({
    super.key,
    this.imageUrl,
    this.petName,
    this.isEmpty = false,
    this.onAdd,
    required Null Function() onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return Column(
        children: [
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 65,
              height: 65,
              decoration: const BoxDecoration(
                color: Color(0xFF3AB7A5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
          SizedBox(height: 6),
          Text("Add Pet"),
        ],
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: context.neutral200,
          backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
              ? NetworkImage(imageUrl!)
              : null,
          child: (imageUrl == null || imageUrl!.isEmpty)
              ? Icon(Icons.pets, color: Colors.grey)
              : null,
        ),
        SizedBox(height: 6),
        Text(petName ?? ""),
      ],
    );
  }
}