import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AvatarStack extends StatelessWidget {
  final List<String> imageUrls;
  final int maxShown;
  final Color baseColor;

  const AvatarStack({
    required this.imageUrls,
    this.maxShown = 3,
    this.baseColor = AppColors.blueTask, // Default to a theme color
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the number of avatars to actually display
    final avatarsToShow = imageUrls.take(maxShown).toList();
    final remainingCount = imageUrls.length - maxShown;

    return Row(
      children: [
        // Build the stack of visible avatars
        ...avatarsToShow.asMap().entries.map((entry) {
          final index = entry.key;
          final url = entry.value;

          return Transform.translate(
            // Shifts each avatar to the left by a small amount for the stacking effect
            offset: Offset(index * -8.0, 0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.cardWhite, // White border/background
                shape: BoxShape.circle,
                border: Border.all(color: baseColor, width: 2), // Thin border to match card
              ),
              padding: const EdgeInsets.all(2), // Inner padding for the image
              child: ClipOval(
                // Placeholder image. In a real app, this would be NetworkImage(url)
                child: Image.asset(
                  'assets/images/user_avatar_${index + 1}.png',
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 20, color: baseColor);
                  },
                ),
              ),
            ),
          );
        }).toList(),

        // Show the count of remaining members if there are more than maxShown
        if (remainingCount > 0)
          Transform.translate(
            offset: Offset(maxShown * -8.0, 0), // Shift the count to align with the stack
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                shape: BoxShape.circle,
                border: Border.all(color: baseColor, width: 2),
              ),
              child: Center(
                child: Text(
                  '+$remainingCount',
                  style: TextStyle(
                    color: AppColors.cardWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    backgroundColor: baseColor, // Use base color as background for the text
                  ),
                ),
              ),
            ),
          ),

        // This ensures the row maintains its intended width despite the negative offsets
        SizedBox(width: maxShown * 8.0 + (remainingCount > 0 ? 30 : 0)),
      ],
    );
  }
}