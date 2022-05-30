import 'package:testttttt/Models/sites.dart';
import 'package:testttttt/UI/views/post_auth_screens/Sites/site_details.dart';

import 'package:http/http.dart' as http;

class SiteCall {
  Future<List<SitesDetails>?> getSites() async {
    var client = http.Client();
    var uri = Uri.parse(
        "https://rhjjm90yii.execute-api.us-east-1.amazonaws.com/default/web_inventory_station_data");

    var response = await client.get(uri,
        headers: {"x-api-key": "TWGR2Kt4eb2LlsY1Y0VO474zOQnwz04o3sFnn4q5"});
    if (response.statusCode == 200) {
      var json = response.body;
      return sitesfromjson(json);
    }
  }
}
