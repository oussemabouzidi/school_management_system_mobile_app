import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:badges/badges.dart' as badges;

class NotificationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return // Notifications
        badges.Badge(
      badgeContent: Text(
        '3',
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
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    title: Text(
                      "Notifications",
                      style: TextStyle(color: Colors.red[400]),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildNotificationItem(
                          title: 'Club Théâtre',
                          description:
                              'Le Club-Théâtre est un lieu dynamique où l\'art du théâtre prend vie',
                          imageAsset: 'images/theatre.png',
                          logoColor: Colors.red,
                        ),
                        SizedBox(height: 16),
                        _buildNotificationItem(
                          title: 'Club de Foot',
                          description: 'Le Club foot est un lieu sportive',
                          imageAsset: 'images/football.png',
                          logoColor: Colors.black,
                        ),
                      ],
                    ),
                  );
                });
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
}

Widget _buildNotificationItem({
  required String title,
  required String description,
  required String imageAsset,
  required Color logoColor,
}) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: logoColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(15),
    ),
    width: 280,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: logoColor,
          radius: 24,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
