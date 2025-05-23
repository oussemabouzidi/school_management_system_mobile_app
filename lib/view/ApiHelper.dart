import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiHelper {
  /// Helper class to test different connection options
  static Future<String> testConnections(String path,
      {Map<String, String>? queryParams}) async {
    // List of server configurations to try
    List<Map<String, dynamic>> serverConfigs = [
      // 1. HTTP with 10.0.2.2 (Android emulator specific)
      {'protocol': 'http', 'host': '10.0.2.2', 'port': 8000},

      // 2. HTTPS with 10.0.2.2 (Android emulator specific)
      {'protocol': 'https', 'host': '10.0.2.2', 'port': 8000},

      // 3. HTTP with localhost
      {'protocol': 'http', 'host': '127.0.0.1', 'port': 8000},

      // 4. HTTPS with localhost
      {'protocol': 'https', 'host': '127.0.0.1', 'port': 8000},

      // 5. HTTP with localhost, no port
      {'protocol': 'http', 'host': '127.0.0.1', 'port': null},

      // Add more configurations if needed
    ];

    // Try each configuration with shorter timeout
    for (var config in serverConfigs) {
      String protocol = config['protocol'];
      String host = config['host'];
      int? port = config['port'];

      String baseUrl = '$protocol://$host';
      if (port != null) baseUrl += ':$port';

      String fullUrl = '$baseUrl/$path';
      if (queryParams != null && queryParams.isNotEmpty) {
        fullUrl += '?';
        queryParams.forEach((key, value) {
          fullUrl += '$key=$value&';
        });
        fullUrl = fullUrl.substring(0, fullUrl.length - 1); // Remove trailing &
      }

      print('Trying connection to: $fullUrl');

      try {
        final response = await http.get(
          Uri.parse(fullUrl),
          headers: {'Accept': 'application/json'},
        ).timeout(const Duration(seconds: 3));

        if (response.statusCode == 200) {
          print('SUCCESS: Connected to $fullUrl');
          return fullUrl; // Return the working URL
        } else {
          print('FAILED: Status ${response.statusCode} from $fullUrl');
        }
      } catch (e) {
        print('ERROR connecting to $fullUrl: $e');
      }
    }

    // If all attempts fail, return empty string
    return '';
  }

  /// Get the best API URL based on testing connection
  static Future<String> getBestApiUrl() async {
    try {
      // First test a simple endpoint that should respond quickly
      String workingUrl = await testConnections('api/ping');

      if (workingUrl.isNotEmpty) {
        // Extract the base URL without the path
        Uri uri = Uri.parse(workingUrl);
        String baseUrl = '${uri.scheme}://${uri.host}';
        if (uri.hasPort) baseUrl += ':${uri.port}';

        print('Found working base URL: $baseUrl');
        return baseUrl;
      }
    } catch (e) {
      print('Error determining best API URL: $e');
    }

    // Fallback based on platform
    if (GetPlatform.isAndroid) {
      return 'http://10.0.2.2:8000';
    } else {
      return 'http://127.0.0.1:8000';
    }
  }

  /// Create HTTP client with proper certificate handling for development
  static http.Client createClient() {
    return http.Client();

    // For handling self-signed certificates (if needed):
    /*
    HttpClient client = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(client);
    */
  }
}
