import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app3/models/Course.dart';
import 'package:my_app3/models/Devoir.dart';
import 'package:my_app3/models/Homework.dart';
import 'package:my_app3/models/LastNotes.dart';
import 'package:my_app3/models/Matiere.dart';
import 'package:my_app3/models/Notification.dart' as Notification;
import 'package:my_app3/models/Payment.dart';
import 'package:my_app3/models/Reunion.dart';
import 'package:my_app3/models/StudentInfo.dart';
import 'package:my_app3/models/User.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app3/shared/SharedPrefsService.dart';

class Service {
  final String baseUrl = 'http://192.168.1.16:8000/api';

  Future<List<Matiere>> getMatieres() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/matiere'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((data) => Matiere.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load matieres: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching matieres: $e');
    }
  }

  Future<Homework> getHomework(int id_eleve, int id_matiere) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/homework/$id_eleve/$id_matiere'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No homework found for this student and subject');
        }
        return Homework.fromJson(jsonData[0]);
      } else {
        throw Exception('Failed to load homework: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching homework data: $e');
    }
  }

  Future<User> getUserLogin(String? email, String? pwd) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/login_eleve?email=$email&pwd=$pwd'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No user found');
        }
        User u = User.fromJson(jsonData[0]);
        return u;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during login: $e');
    }
  }

  Future<List<Reunion>> getReunion(int? id) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/reunion/filter_by_parent?id=$id'));
      List<Reunion> ls_reunion = [];
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No reunion found');
        }
        for (var item in jsonData) {
          Reunion r = Reunion.fromJson(item);
          ls_reunion.add(r);
        }
        return ls_reunion;
      } else {
        throw Exception('Failed to get reunion: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting reunion : $e');
    }
  }

  Future<Course> getCourse(int? eleve_id, int? matiere_id) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/course/filtered?eleve_id=$eleve_id&matiere_id=$matiere_id'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No user found');
        }
        Course c = Course.fromJson(jsonData[0]);
        return c;
      } else {
        throw Exception('Failed to get courses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting course : $e');
    }
  }

  Future<List<Payment>> getPayements(int id_parent, String type) async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/payment/filtred/payments?id=$id_parent&type=$type'));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No payement found');
        }
        List<Payment> ls = [];
        for (var item in jsonData) {
          ls.add(Payment.fromJson(item));
        }
        return ls;
      } else {
        throw Exception('Failed to get payement: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting payement : $e');
    }
  }

  Future<List<Notification.Notification>> getNotifications() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notification/getAll'),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          return []; // Return empty list instead of throwing an exception
        }

        List<Notification.Notification> notifications = jsonData
            .map((item) => Notification.Notification.fromJson(item))
            .toList();

        return notifications;
      } else {
        throw Exception('Failed to get notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting notifications: $e');
    }
  }

  // Add method to mark notification as read
  Future<bool> markAsRead(int notificationId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/notification/markRead'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'notification_id': notificationId,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error marking notification as read: $e');
      return false;
    }
  }

  // Get unread notification count
  Future<int> getUnreadCount() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/notification/unreadCount'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['count'] ?? 0;
      } else {
        return 0;
      }
    } catch (e) {
      print('Error getting unread count: $e');
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getElevesProfiles(int id_parent) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/parent/geteleve?parent_id=$id_parent'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)
            as List<dynamic>; // Decoding to List<dynamic>

        // Ensure that every item is a Map<String, dynamic>
        final List<Map<String, dynamic>> result = data.map((e) {
          if (e is Map<String, dynamic>) {
            return e;
          } else {
            // If the item isn't a Map, handle it accordingly
            throw Exception(
                'Expected a Map<String, dynamic>, but got something else.');
          }
        }).toList();

        return result;
      } else {
        throw Exception('Failed to get eleves profiles');
      }
    } catch (e) {
      throw Exception('An error occurred when getting eleves profiles: $e');
    }
  }

  Future<Studentinfo> getStudentsInfo(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/parent/getEleveInfoToUpdate?id=$id'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data.isEmpty) {
          throw Exception('No user found');
        }
        Studentinfo si = Studentinfo.fromJson(data[0]);
        return si;
      } else {
        throw Exception('An error occurred when getting sduents infos');
      }
    } catch (e) {
      throw Exception('An error occurred when getting sduents infos : $e');
    }
  }

  Future<bool> updateStudentInfo(
      int studentId, Map<String, dynamic> updateData) async {
    final url = Uri.parse('$baseUrl/student/$studentId/update-profile');

    try {
      final response = await http.put(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(updateData),
      );

      print(jsonEncode(updateData));

      if (response.statusCode == 200) {
        print('Update success: ${response.body}');
        return true;
      } else {
        print('Update failed: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during update: $e');
      return false;
    }
  }

  Future<Position> determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      /*ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Activer localisation")));*/
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Optional: Show a dialog explaining why location is needed before requesting permission
      bool shouldRequest = await showPermissionRationaleDialog(context);

      if (shouldRequest) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          // User denied permission again
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Permission de localisation refusée. Veuillez l'activer pour continuer.")),
          );
          return Future.error('Location permissions are denied');
        }
      } else {
        // User chose not to proceed with permission request
        return Future.error('User cancelled permission rationale');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      bool openSettings = await showPermissionSettingsDialog(context);

      if (openSettings) {
        await Geolocator.openAppSettings();
      }
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var position = await Geolocator.getCurrentPosition();
    print(position);
    return position;
  }

  Future<bool> showPermissionRationaleDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Permission nécessaire"),
            content: const Text(
              "L'application a besoin de la localisation pour fonctionner correctement. Voulez-vous autoriser l'accès ?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Non"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Oui"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<bool> showPermissionSettingsDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Permission bloquée"),
            content: const Text(
              "La permission de localisation a été définitivement refusée. "
              "Veuillez l'activer manuellement dans les paramètres de l'application.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("Annuler"),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("Ouvrir les paramètres"),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool checkIfNearTarget(Position currentPosition) {
    double targetLatitude = 36.5818022;
    double targetLongitude = 10.8591453;

    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      targetLatitude,
      targetLongitude,
    );

    if (distanceInMeters <= 50) {
      // Near the location (within 50 meters)
      print("✅ You are near the target location!");
      return true;
      // Your code here
    } else {
      print("❌ Not near the target location.");
      return false;
    }
  }

  Future<List<Lastnotes>> getLastNotes() async {
    String? id_eleve = await SharedPrefsService.getUserId();
    final url = Uri.parse('$baseUrl/note/eleve/lasts?eleve_id=$id_eleve');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Lastnotes> ls = [];

        if (data.isEmpty) {
          throw Exception('No grade was found');
        }
        for (var item in data) {
          ls.add(Lastnotes.fromJson(item));
        }
        return ls;
      } else {
        throw Exception('Failed to get latest grades: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting latest grades : $e');
    }
  }

  Future<Devoir> getLastsDevoir() async {
    String? id_eleve = await SharedPrefsService.getUserId();
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/devoir/latest?eleve_id=$id_eleve'));

      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        if (jsonData.isEmpty) {
          throw Exception('No exam was found');
        }
        Devoir dv = Devoir.fromJson(jsonData[0]);
        return dv;
      } else {
        throw Exception('Failed to found exam : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error during getting exam : $e');
    }
  }
}
