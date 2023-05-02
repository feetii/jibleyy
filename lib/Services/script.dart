import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  String accessToken = 'your_access_token_here';
  String sheetId = 'your_sheet_id_here';
  String range = 'Sheet1!A1:D5';
  String apiUrl = 'https://sheets.googleapis.com/v4/spreadsheets/$sheetId/values/$range';

  var response = await http.get(Uri.parse(apiUrl), headers: {
    'Authorization': 'Bearer $accessToken',
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
