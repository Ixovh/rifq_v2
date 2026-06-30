import 'package:flutter/material.dart';

class AddPetCircleWidget extends StatelessWidget {
  final VoidCallback onTap;

  const AddPetCircleWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF3AB7A5),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white, size: 32),
          ),
          SizedBox(height: 6),
          Text(
            "Add Pet",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}