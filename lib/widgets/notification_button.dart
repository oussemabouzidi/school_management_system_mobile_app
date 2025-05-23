import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:badges/badges.dart' as badges;
import 'dart:async';
import 'package:my_app3/models/Notification.dart' as model;

import 'package:my_app3/services/Services.dart';

// Import your service

class NotificationButton extends StatefulWidget {
  final Service notificationService;

  const NotificationButton({
    Key? key,
    required this.notificationService,
  }) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  int _unreadCount = 0;
  List<model.Notification> _notifications = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final notifications = await widget.notificationService.getNotifications();
      setState(() {
        _notifications = notifications;
        _unreadCount = notifications.where((n) => n.is_read == 0).length;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load notifications';
        _isLoading = false;
      });
      print('Error loading notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      showBadge: _unreadCount > 0,
      badgeContent: Text(
        _unreadCount.toString(),
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.red,
        padding: EdgeInsets.all(6),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: IconButton(
          onPressed: () {
            _showNotificationsDialog(context);
          },
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedNotification03,
            size: 24.0,
            color: Colors.grey[700]!,
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Notifications",
                style: TextStyle(color: Colors.red[400]),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                  _loadNotifications();
                  _showNotificationsDialog(context);
                },
              ),
            ],
          ),
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: _buildNotificationsList(),
          ),
        );
      },
    );
  }

  Widget _buildNotificationsList() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadNotifications,
              child: Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_off_outlined,
                size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No notifications yet', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      itemCount: _notifications.length,
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () {
            // Mark as read if needed
            if (notification.is_read == 0) {
              // Here you would call an API to mark as read
              // Then refresh the notifications list
            }
          },
        );
      },
    );
  }
}

class NotificationItem extends StatelessWidget {
  final model.Notification notification;
  final VoidCallback onTap;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine notification color based on type
    Color notificationColor = _getColorForType(notification.type);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: notification.is_read == 0
              ? notificationColor.withOpacity(0.15)
              : notificationColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(15),
          border: notification.is_read == 0
              ? Border.all(color: notificationColor.withOpacity(0.3), width: 1)
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNotificationImage(notification, notificationColor),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontWeight: notification.is_read == 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        _formatTimestamp(notification.created_at),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    notification.content,
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationImage(model.Notification notification, Color color) {
    // If there's an image URL, use NetworkImage, otherwise use an icon based on type
    if (notification.image.isNotEmpty && notification.image != "null") {
      return CircleAvatar(
        backgroundColor: color,
        radius: 24,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Image.network(
            notification.image,
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image_not_supported, color: Colors.white);
            },
          ),
        ),
      );
    } else {
      // Use type-specific icon
      return CircleAvatar(
        backgroundColor: color,
        radius: 24,
        child: Icon(
          _getIconForType(notification.type),
          color: Colors.white,
        ),
      );
    }
  }

  Color _getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'info':
        return Colors.blue;
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'error':
        return Colors.red;
      case 'club':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getIconForType(String type) {
    switch (type.toLowerCase()) {
      case 'info':
        return Icons.info_outline;
      case 'success':
        return Icons.check_circle_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'error':
        return Icons.error_outline;
      case 'club':
        return Icons.groups_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  String _formatTimestamp(String timestamp) {
    final dateTime = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      // More than a week ago - show date
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      // Days ago
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      // Hours ago
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      // Minutes ago
      return '${difference.inMinutes}m ago';
    } else {
      // Just now
      return 'Just now';
    }
  }
}
