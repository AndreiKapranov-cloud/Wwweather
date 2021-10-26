public with sharing class CityChild {
    public City__c getChild(String responseBody) {
      Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
        responseBody
      );
  
      City__c cityChild = new City__c();
      Map<String, Object> cityMap = (Map<String, Object>) responseMap.get('city');
      String cityFromJson = String.valueOf(cityMap.get('name'));
      String countryFromJson = String.valueOf(cityMap.get('country'));
      cityChild.Country__c = countryFromJson;
      cityChild.Name = cityFromJson;
      upsert cityChild;
      return cityChild;
    }
  }