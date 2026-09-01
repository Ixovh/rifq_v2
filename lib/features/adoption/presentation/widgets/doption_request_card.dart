import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';

class AdoptionRequestCard extends StatelessWidget {
  final AdoptionRequestCardEntity request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool isUpdating;

  const AdoptionRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
    this.isUpdating = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPending = request.status.toLowerCase() == 'pending';

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 125.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(),

          SizedBox(width: 12.w),

          Expanded(
            child: _buildInformation(isPending),
          ),

          SizedBox(width: 5.w),

          if (isPending)
            _buildActions()
          else
            _buildStatus(),
        ],
      ),
    );
  }

  // =========================
  // Avatar
  // =========================

  Widget _buildAvatar() {
    return ClipOval(
      child: SizedBox(
        width: 88.w,
        height: 88.w,
        child: request.avatarUrl != null &&
                request.avatarUrl!.isNotEmpty
            ? Image.network(
                request.avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _defaultAvatar();
                },
              )
            : _defaultAvatar(),
      ),
    );
  }

  Widget _defaultAvatar() {
    return Container(
      color: Colors.grey.shade200,
      child: Icon(
        Icons.person,
        size: 45.sp,
        color: Colors.grey,
      ),
    );
  }

  // =========================
  // Information
  // =========================

  Widget _buildInformation(bool isPending) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                request.fullName ?? 'Unknown',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ),

            if (isPending) ...[
              SizedBox(width: 8.w),
              _buildNewBadge(),
            ],
          ],
        ),

        SizedBox(height: 5.h),

        if (request.location != null)
          _infoRow(
            Icons.location_on,
            request.location!,
          ),

        if (request.phoneNumber != null)
          _infoRow(
            Icons.phone,
            request.phoneNumber!,
          ),

        if (request.experience != null &&
            request.experience!.trim().isNotEmpty)
          _infoRow(
            Icons.pets_outlined,
            request.experience!,
          ),

        if (request.message != null &&
            request.message!.trim().isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: Text(
              '"${request.message!}"',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade500,
                height: 1.15,
              ),
            ),
          ),

        SizedBox(height: 4.h),

        if (request.createdAt != null)
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatDate(request.createdAt!),
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(width: 3.w),
                Icon(
                  Icons.access_time,
                  size: 11.sp,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
      ],
    );
  }

  // =========================
  // Info Row
  // =========================

  Widget _infoRow(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Row(
        children: [
          Icon(
            icon,
            size: 15.sp,
            color: Colors.grey.shade600,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey.shade500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // New Badge
  // =========================

  Widget _buildNewBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FFF8),
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(
          color: const Color(0xFF8BE8B8),
        ),
      ),
      child: Text(
        'New',
        style: TextStyle(
          fontSize: 12.sp,
          color: const Color(0xFF087A4D),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // =========================
  // Accept / Reject
  // =========================

  Widget _buildActions() {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _actionButton(
            icon: Icons.check,
            backgroundColor: const Color(0xFF16B364),
            onTap: isUpdating ? null : onAccept,
          ),

          SizedBox(height: 14.h),

          _actionButton(
            icon: Icons.close,
            backgroundColor: const Color(0xFFFF482D),
            onTap: isUpdating ? null : onReject,
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: onTap == null
              ? backgroundColor.withOpacity(0.4)
              : backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 27.sp,
        ),
      ),
    );
  }

  // =========================
  // Status
  // =========================

  Widget _buildStatus() {
    final status = request.status.toLowerCase();

    String text;
    Color color;

    if (status == 'accepted') {
      text = 'Accepted';
      color = const Color(0xFF16B364);
    } else {
      text = 'Rejected';
      color = const Color(0xFFFF482D);
    }

    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }
}