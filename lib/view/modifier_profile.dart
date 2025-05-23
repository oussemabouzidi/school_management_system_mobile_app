import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:my_app3/models/StudentInfo.dart';
import 'package:my_app3/services/Services.dart';
import 'package:my_app3/widgets/notification_button.dart';

class ModifierProfil extends StatefulWidget {
  final int studentId;

  const ModifierProfil({Key? key, required this.studentId}) : super(key: key);

  @override
  _ModifierProfilState createState() => _ModifierProfilState();
}

class _ModifierProfilState extends State<ModifierProfil> {
  // Controllers for personal information
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Controllers for father information
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _fatherPrenomController = TextEditingController();
  final TextEditingController _fatherTelController = TextEditingController();
  final TextEditingController _fatherEmailController = TextEditingController();

  // Controllers for mother information
  final TextEditingController _motherNameController = TextEditingController();
  final TextEditingController _motherPrenomController = TextEditingController();
  final TextEditingController _motherTelController = TextEditingController();
  final TextEditingController _motherEmailController = TextEditingController();

  // Controllers for emergency contact
  final TextEditingController _emergencyNameController =
      TextEditingController();
  final TextEditingController _emergencyPhoneController =
      TextEditingController();
  final TextEditingController _emergencyRelationController =
      TextEditingController();

  // For profile image
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Section visibility
  bool _showEmergencyContact = false;
  bool _showFatherInfo = false;
  bool _showMotherInfo = false;

  // For API data
  bool _isLoading = true;
  Studentinfo? _studentInfo;
  final Service _service = Service();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchStudentInfo();
  }

  @override
  void dispose() {
    // Dispose all controllers to prevent memory leaks
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _fatherNameController.dispose();
    _fatherPrenomController.dispose();
    _fatherTelController.dispose();
    _fatherEmailController.dispose();
    _motherNameController.dispose();
    _motherPrenomController.dispose();
    _motherTelController.dispose();
    _motherEmailController.dispose();
    _emergencyNameController.dispose();
    _emergencyPhoneController.dispose();
    _emergencyRelationController.dispose();
    super.dispose();
  }

  Future<void> _fetchStudentInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final studentInfo = await _service.getStudentsInfo(widget.studentId);
      setState(() {
        _studentInfo = studentInfo;
        _isLoading = false;
        _populateFormFields();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  void _populateFormFields() {
    if (_studentInfo != null) {
      // Personal information
      _phoneController.text = _studentInfo!.tel ?? "";
      _emailController.text = _studentInfo!.email ?? "";
      _addressController.text = _studentInfo!.adresse ?? "";

      // Father information
      _fatherNameController.text = _studentInfo!.father_name ?? "";
      _fatherPrenomController.text = _studentInfo!.father_prenom ?? "";
      _fatherTelController.text = _studentInfo!.father_tel ?? "";
      _fatherEmailController.text = _studentInfo!.father_email ?? "";

      // Mother information
      _motherNameController.text = _studentInfo!.mother_name ?? "";
      _motherPrenomController.text = _studentInfo!.mother_prenom ?? "";
      _motherTelController.text = _studentInfo!.mother_tel ?? "";
      _motherEmailController.text = _studentInfo!.mother_email ?? "";
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de la sélection de l'image: $e")),
        );
      }
    }
  }

  void _showPreviewDialog() {
    // Ensure the context is still valid
    if (!mounted) return;

    try {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            // Constrain the dialog size
            child: Container(
              width: double.maxFinite,
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog title
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Aperçu des modifications",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),

                  // Content in a scrollable container that won't overflow
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile image preview
                            if (_imageFile != null)
                              Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  child: Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Icon(
                                            Icons.person,
                                            size: 60,
                                            color: Colors.grey[400]),
                                  ),
                                ),
                              ),
                            SizedBox(height: 16),

                            // Personal information preview
                            Text(
                              "Informations personnelles",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            _buildPreviewItem(
                                "Téléphone", _phoneController.text),
                            _buildPreviewItem("Email", _emailController.text),
                            _buildPreviewItem(
                                "Adresse", _addressController.text),

                            SizedBox(height: 16),

                            // Father information preview
                            if (_showFatherInfo) ...[
                              Text(
                                "Information du père",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              _buildPreviewItem(
                                  "Nom", _fatherNameController.text),
                              _buildPreviewItem(
                                  "Prénom", _fatherPrenomController.text),
                              _buildPreviewItem(
                                  "Téléphone", _fatherTelController.text),
                              _buildPreviewItem(
                                  "Email", _fatherEmailController.text),
                              SizedBox(height: 16),
                            ],

                            // Mother information preview
                            if (_showMotherInfo) ...[
                              Text(
                                "Information de la mère",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              _buildPreviewItem(
                                  "Nom", _motherNameController.text),
                              _buildPreviewItem(
                                  "Prénom", _motherPrenomController.text),
                              _buildPreviewItem(
                                  "Téléphone", _motherTelController.text),
                              _buildPreviewItem(
                                  "Email", _motherEmailController.text),
                              SizedBox(height: 16),
                            ],

                            // Emergency contact preview
                            if (_showEmergencyContact) ...[
                              Text(
                                "Contact d'urgence",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              _buildPreviewItem(
                                  "Nom", _emergencyNameController.text),
                              _buildPreviewItem(
                                  "Téléphone", _emergencyPhoneController.text),
                              _buildPreviewItem("Relation",
                                  _emergencyRelationController.text),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Button row
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: Text("Modifier"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          child: Text("Confirmer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4E7DFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(dialogContext).pop();
                            _saveChanges();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur lors de l'aperçu: $e")),
        );
      }
    }
  }

  Future<void> _saveChanges() async {
    try {
      // First pop the preview dialog
      if (mounted) Navigator.of(context).pop();

      // Create update data structure
      Map<String, dynamic> updateData = {
        'student': {
          'tel': _phoneController.text,
          'email': _emailController.text,
          'adresse': _addressController.text,
        },
        'father': {
          'nom': _fatherNameController.text,
          'prenom': _fatherPrenomController.text,
          'tel': _fatherTelController.text,
          'email': _fatherEmailController.text,
        },
        'mother': {
          'nom': _motherNameController.text,
          'prenom': _motherPrenomController.text,
          'tel': _motherTelController.text,
          'email': _motherEmailController.text,
        },
      };

      if (_showEmergencyContact) {
        updateData['emergency'] = {
          'nom': _emergencyNameController.text,
          'tel': _emergencyPhoneController.text,
          'relation': _emergencyRelationController.text,
        };
      }

      // Send the update request
      bool success =
          await _service.updateStudentInfo(widget.studentId, updateData);

      if (!mounted) return; // Check if widget is still in the tree

      if (success) {
        Get.snackbar(
          'Succès',
          'Modification effectué avec succès',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          margin: EdgeInsets.all(16),
          duration: Duration(seconds: 3),
          icon: Icon(Icons.check_circle, color: Colors.green),
          borderRadius: 10,
          boxShadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 2),
            )
          ],
        );

        // Upload image if available
        if (_imageFile != null) {
          // Here you would implement the image upload
          // await _service.uploadStudentImage(widget.studentId, _imageFile!);
        }

        // Return to previous screen
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Échec de la mise à jour du profil"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Erreur lors de l'enregistrement: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showOfficialModificationDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Demande de modification officielle",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pour modifier des informations sensibles comme votre nom, date de naissance ou autres données officielles, veuillez soumettre une demande à l'administration.",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Décrivez les informations à modifier",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Annuler"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: Text("Soumettre"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4E7DFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pop();
                Get.snackbar(
                  'Succès',
                  'Demande envoyée avec succès',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  duration: Duration(seconds: 2),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            value.isEmpty ? '---' : value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Color(0xFF4E7DFF),
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              "Erreur lors du chargement des données",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(_errorMessage!),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _fetchStudentInfo,
              child: Text("Réessayer"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4E7DFF),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top navigation bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),

                  // Page title
                  Text(
                    "Modifier le profil",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),

                  // Notification button with badge
                  NotificationButton(
                    notificationService: _service,
                  )
                ],
              ),
            ),

            // Student Name
            if (_studentInfo != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Center(
                  child: Text(
                    "${_studentInfo!.prenom ?? ''} ${_studentInfo!.name ?? ''}",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            // Profile image section
            _buildSectionCard(
              title: 'Photo de profil',
              content: Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade200,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    fit: BoxFit.cover,
                                  )
                                : _studentInfo?.image != null &&
                                        _studentInfo!.image!.isNotEmpty
                                    ? Image.network(
                                        _studentInfo!.image!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Image.asset('images/student.png',
                                                fit: BoxFit.cover),
                                      )
                                    : Image.asset(
                                        'images/student.png',
                                        fit: BoxFit.cover,
                                      ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF4E7DFF),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Appuyez pour changer la photo",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Personal information form
            _buildSectionCard(
              title: 'Informations Personnelles',
              content: Column(
                children: [
                  _buildFormField(
                    label: "Contact téléphonique",
                    controller: _phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(height: 16),
                  _buildFormField(
                    label: "Email",
                    controller: _emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  _buildFormField(
                    label: "Adresse",
                    controller: _addressController,
                    icon: Icons.home,
                    keyboardType: TextInputType.streetAddress,
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Father information
            _buildSectionCard(
              title: 'Information du père',
              showToggle: true,
              isExpanded: _showFatherInfo,
              onToggle: (value) {
                setState(() {
                  _showFatherInfo = value;
                });
              },
              content: _showFatherInfo
                  ? Column(
                      children: [
                        _buildFormField(
                          label: "Nom",
                          controller: _fatherNameController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Prénom",
                          controller: _fatherPrenomController,
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Téléphone",
                          controller: _fatherTelController,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Email",
                          controller: _fatherEmailController,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(height: 16),

            // Mother information
            _buildSectionCard(
              title: 'Information de la mère',
              showToggle: true,
              isExpanded: _showMotherInfo,
              onToggle: (value) {
                setState(() {
                  _showMotherInfo = value;
                });
              },
              content: _showMotherInfo
                  ? Column(
                      children: [
                        _buildFormField(
                          label: "Nom",
                          controller: _motherNameController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Prénom",
                          controller: _motherPrenomController,
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Téléphone",
                          controller: _motherTelController,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Email",
                          controller: _motherEmailController,
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(height: 16),

            // Emergency contact section
            _buildSectionCard(
              title: 'Contact d\'urgence',
              showToggle: true,
              isExpanded: _showEmergencyContact,
              onToggle: (value) {
                setState(() {
                  _showEmergencyContact = value;
                });
              },
              content: _showEmergencyContact
                  ? Column(
                      children: [
                        _buildFormField(
                          label: "Nom du contact",
                          controller: _emergencyNameController,
                          icon: Icons.person,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Contact téléphonique",
                          controller: _emergencyPhoneController,
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone,
                        ),
                        SizedBox(height: 16),
                        _buildFormField(
                          label: "Relation",
                          controller: _emergencyRelationController,
                          icon: Icons.family_restroom,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ),

            SizedBox(height: 24),

            // Official modification request button
            GestureDetector(
              onTap: _showOfficialModificationDialog,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.amber.shade800,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Demander une modification officielle",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Pour les informations sensibles (nom, date de naissance, etc.)",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.amber.shade800,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Annuler",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Color(0xFF2D3142),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showPreviewDialog();
                    },
                    child: Text(
                      "Aperçu",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4E7DFF),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required Widget content,
    bool showToggle = false,
    bool isExpanded = true,
    Function(bool)? onToggle,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF6F6F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color(0xFF2D3142),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (showToggle && onToggle != null)
                  Switch(
                    value: isExpanded,
                    onChanged: onToggle,
                    activeColor: Color(0xFF4E7DFF),
                  ),
              ],
            ),
          ),

          // Content
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: content,
            ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF4E7DFF)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
