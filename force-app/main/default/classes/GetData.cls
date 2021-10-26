public with sharing class GetData {
    public static String getResponseFromAPI(String city) {
      Weather_Setting__c ws = Weather_Setting__c.getOrgDefaults();
      String apiKey = ws.Api_Key__c;
      String result;
      Http http = new Http();
      HttpRequest request = new HttpRequest();
      String unit = 'metric';
      String endpoint = ws.Forecast_Service_URL__c;
      endpoint += city + '&appid=' + apiKey + '&units=' + unit;
      request.setEndpoint(endpoint);
      request.setMethod('GET');
      HttpResponse res = http.send(request);
      result = res.getBody();
  
      if (res.getStatusCode() == 404) {
        throw new AuraHandledException('City not found');
      }
  
      return result;
    }
  }