import 'package:get/get.dart';
import 'package:hokoo_flutter/Api_Service/Fetch_Country/Global_Country/global_country_model.dart';
import 'global_country_service.dart';

class GlobalCountryController extends GetxController {
  var isLoading = true.obs;
  GlobalCountryModel? globalCountryData;

  Future globalCountry() async {
    try {
      isLoading(true);
      globalCountryData = await GlobalCountryService.globalCountry();
      if (globalCountryData!.status == true) {
        Flag globalModel = Flag(
            id: "",
            name: "Global",
            flag: "https://www.svgrepo.com/show/285172/planet-earth-global.svg",
            createdAt: "",
            updatedAt: "");
        globalCountryData!.flag!.insert(0, globalModel);
        isLoading(false);
      }
    } finally {
      isLoading(false);
    }
  }
}
