import 'package:flutter/material.dart';
import 'package:my_app3/services/Services.dart';

class PresenceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return // Presence Card
        Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () async {
          Service service = Service();
          var position = await service.determinePosition(context);
          if (service.checkIfNearTarget(position)) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Votre présence est marqué !"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("images/done.png"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 80,
                              child: Center(
                                child: Text("Ok"),
                              ),
                            ))
                      ],
                    ),
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Vous n'est pas en class !"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset("images/undone.png"),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 80,
                              child: Center(
                                child: Text("Ok"),
                              ),
                            ))
                      ],
                    ),
                  );
                });
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Column(
          children: [
            Text(
              "Marqué votre présence",
              style: TextStyle(
                color: Color(0xFF2D3142),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            Image.asset(
              'images/presence.png',
              width: 80,
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}
