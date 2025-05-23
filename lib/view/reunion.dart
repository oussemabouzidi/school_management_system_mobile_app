import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:circular_gradient_spinner/circular_gradient_spinner.dart';
import 'package:intl/intl.dart';
import 'package:my_app3/controller/reunion_controller.dart';
import 'package:my_app3/models/Reunion.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/notification_button.dart';

class ReunionScreen extends StatelessWidget {
  final ReunionController controller = Get.put(ReunionController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          children: [
            // Top Navigation Bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: 35,
                    height: 35,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        surfaceTintColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.black54),
                    ),
                  ),

                  // Title
                  const Text(
                    "Réunions Parents",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Notifications badge
                  NotificationButton(
                    notificationService: Service(),
                  )
                ],
              ),
            ),

            // Header with animation
            TweenAnimationBuilder(
              duration: Duration(milliseconds: 800),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade400, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "Réunions Parents-Professeurs",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Consultez et confirmez vos rendez-vous",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Loading indicator, error message, or reunions list
            controller.isLoading.value
                ? Center(
                    child: CircularGradientSpinner(
                      color: Colors.blue,
                      size: 50,
                      strokeWidth: 20,
                    ),
                  )
                : controller.hasError.value
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 60,
                              color: Colors.red.shade400,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Erreur de chargement",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red.shade400,
                              ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                controller.errorMessage.value,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => controller.fetchReunion(),
                              icon: Icon(Icons.refresh),
                              label: Text("Réessayer"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                            ),
                          ],
                        ),
                      )
                    : controller.reunions.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Image.asset(
                                    "images/no_data.png", // Replace with your actual asset
                                    height: 120,
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    "Aucune réunion planifiée pour le moment",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Les réunions seront affichées ici une fois programmées",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : _buildReunionsList(context),

            SizedBox(height: 80), // Extra space at bottom for navigation bar
          ],
        ));
  }

  Widget _buildReunionsList(BuildContext context) {
    // Define a list of gradient colors for each meeting card
    final List<List<Color>> cardGradients = [
      [Colors.teal.shade400, Colors.teal.shade700],
      [Colors.blue.shade400, Colors.blue.shade700],
      [Colors.indigo.shade400, Colors.indigo.shade700],
      [Colors.cyan.shade400, Colors.cyan.shade700],
      [Colors.lightBlue.shade400, Colors.lightBlue.shade700],
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: controller.reunions.asMap().entries.map((entry) {
          int idx = entry.key;
          Reunion reunion = entry.value;

          // Format the date
          String formattedDate = _formatDateForDisplay(reunion.date_meeting);
          int daysRemaining = _daysRemaining(reunion.date_meeting);

          List<Color> cardGradient = cardGradients[idx % cardGradients.length];

          // Status indicator color
          Color statusColor;
          IconData statusIcon;

          switch (reunion.status.toLowerCase()) {
            case 'confirmed':
              statusColor = Colors.green;
              statusIcon = Icons.check_circle;
              break;
            case 'cancelled':
              statusColor = Colors.red;
              statusIcon = Icons.cancel;
              break;
            case 'pending':
              statusColor = Colors.orange;
              statusIcon = Icons.access_time;
              break;
            default:
              statusColor = Colors.blue;
              statusIcon = Icons.info;
          }

          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: cardGradient[0].withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    // Meeting header with gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: cardGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: _getIconForReunionType(reunion.type),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  reunion.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  reunion.type,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: statusColor, width: 1),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(statusIcon, size: 14, color: statusColor),
                                SizedBox(width: 4),
                                Text(
                                  reunion.status,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Meeting content
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Location and date row
                          Row(
                            children: [
                              // Location
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: cardGradient[0].withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.location_on,
                                        color: cardGradient[0],
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        reunion.location,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 16),
                              // Date
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: cardGradient[0].withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        Icons.event,
                                        color: cardGradient[0],
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        formattedDate,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12),

                          // Description
                          Text(
                            reunion.description,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),

                          SizedBox(height: 12),

                          // Days remaining and action buttons
                          Row(
                            children: [
                              // Days remaining
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _getDaysRemainingColor(daysRemaining)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        _getDaysRemainingColor(daysRemaining),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  daysRemaining > 0
                                      ? "Dans $daysRemaining jour${daysRemaining > 1 ? 's' : ''}"
                                      : daysRemaining == 0
                                          ? "Aujourd'hui"
                                          : "Passé",
                                  style: TextStyle(
                                    color:
                                        _getDaysRemainingColor(daysRemaining),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Spacer(),

                              // Details button
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: cardGradient,
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      _showReunionDetails(
                                          context, reunion, cardGradient);
                                    },
                                    borderRadius: BorderRadius.circular(20),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.visibility,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'Détails',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Show meeting details dialog
  void _showReunionDetails(
      BuildContext context, Reunion reunion, List<Color> colors) {
    String formattedDate = _formatDateForDisplay(reunion.date_meeting);
    //String formattedTime = DateFormat('HH:mm').format(reunion.date_meeting);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 10),
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            // Header
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: _getIconForReunionType(reunion.type),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reunion.title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          reunion.type,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status indicator
                    Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color:
                              _getStatusColor(reunion.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: _getStatusColor(reunion.status),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon(reunion.status),
                              color: _getStatusColor(reunion.status),
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              reunion.status,
                              style: TextStyle(
                                color: _getStatusColor(reunion.status),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 25),

                    // Info cards section
                    Row(
                      children: [
                        // Date card
                        Expanded(
                          flex: 1,
                          child: _buildInfoCard(
                            colors[0],
                            Icons.calendar_today,
                            "Date",
                            formattedDate,
                          ),
                        ),
                        SizedBox(width: 15),
                        // Time card
                        Expanded(
                          flex: 1,
                          child: _buildInfoCard(
                              colors[0],
                              Icons.access_time,
                              "Heure",
                              /*formattedTime*/
                              "1h"),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    // Location card
                    _buildInfoCard(
                      colors[0],
                      Icons.location_on,
                      "Lieu",
                      reunion.location,
                    ),

                    SizedBox(height: 25),

                    // Description section
                    Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colors[0],
                      ),
                    ),

                    SizedBox(height: 10),

                    // Full description
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: colors[0].withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        reunion.description,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    SizedBox(height: 30),

                    // Action buttons
                    Row(
                      children: [
                        // Decline button
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  // Add decline logic here
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Center(
                                  child: Text(
                                    'Décliner',
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Confirm button
                        Expanded(
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: colors,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: colors[0].withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  // Add confirm logic here
                                },
                                borderRadius: BorderRadius.circular(25),
                                child: Center(
                                  child: Text(
                                    'Confirmer',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Widget _buildInfoCard(
      Color color, IconData icon, String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // Get icon based on reunion type
  Icon _getIconForReunionType(String type) {
    final String lowerType = type.toLowerCase();

    if (lowerType.contains('parent')) {
      return Icon(Icons.people, color: Colors.white, size: 28);
    } else if (lowerType.contains('individuel')) {
      return Icon(Icons.person, color: Colors.white, size: 28);
    } else if (lowerType.contains('orientation')) {
      return Icon(Icons.map, color: Colors.white, size: 28);
    } else if (lowerType.contains('remise')) {
      return Icon(Icons.assignment, color: Colors.white, size: 28);
    } else if (lowerType.contains('urgence')) {
      return Icon(Icons.priority_high, color: Colors.white, size: 28);
    } else {
      return Icon(Icons.event_note, color: Colors.white, size: 28);
    }
  }

  // Format date for display
  String _formatDateForDisplay(dynamic dateInput) {
    // Handle both DateTime and String cases
    if (dateInput is DateTime) {
      return DateFormat('dd/MM/yyyy').format(dateInput);
    } else if (dateInput is String) {
      try {
        // Try to parse as ISO format first
        DateTime parsedDate = DateTime.parse(dateInput);
        return DateFormat('dd/MM/yyyy').format(parsedDate);
      } catch (e) {
        // If that fails, try DD/MM/YYYY format
        try {
          DateFormat inputFormat = DateFormat("dd/MM/yyyy");
          DateTime parsedDate = inputFormat.parse(dateInput);
          return DateFormat('dd/MM/yyyy').format(parsedDate);
        } catch (e) {
          print('Error parsing date: $e');
          return dateInput; // Return as is if we can't parse
        }
      }
    }
    return "Date indisponible"; // Fallback
  }

  // Calculate days remaining until meeting
  int _daysRemaining(String dateString) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Parse the string to DateTime
    final parsedDate = DateTime.parse(dateString);
    final meetingDay =
        DateTime(parsedDate.year, parsedDate.month, parsedDate.day);

    return meetingDay.difference(today).inDays;
  }

  // Get color based on days remaining
  Color _getDaysRemainingColor(int days) {
    if (days < 0) return Colors.grey;
    if (days == 0) return Colors.red;
    if (days <= 2) return Colors.orange;
    if (days <= 7) return Colors.amber.shade700;
    return Colors.green;
  }

  // Get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  // Get status icon
  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.access_time;
      default:
        return Icons.info;
    }
  }
}
