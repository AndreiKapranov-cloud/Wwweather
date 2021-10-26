public with sharing class CityNameIntoMap {
    public static Map<String, Object> getMap(String city) {
    
    String responseBody = GetData.getResponseFromAPI(city);
  
    Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
      responseBody
    );
    return responseMap;
  }
  public static List<Forecast__c>  gettingWeatherMessageFromSetting(List<Forecast__c> objList){
    upsert objList;
  List<Forecast__c> sel = [
    SELECT
      Name,
      Temperature__c,
      Weather_message__c,
      Date__c,
      Time__c,
      City__c
    FROM Forecast__c
    WHERE Id IN :objList
  ];
  return sel;
  }
  public static List<Forecast__c> createCircle(String responseBody) {
    Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
        responseBody);
    CityChild cityChild = new CityChild();
  List<Forecast__c> objList = new List<Forecast__c>();
  City__c cityObj = cityChild.getChild(responseBody);

  for (Integer i = 0; i < 40; i++) {
    Forecast__c forecast = new Forecast__c();

    List<Object> ListGlobal = (List<Object>) responseMap.get('list');
    Map<String, Object> weatherInfoGlobal = (Map<String, Object>) ListGlobal[
      i
    ];
    Map<String, Object> mainMap = (Map<String, Object>) weatherInfoGlobal.get(
      'main'
    );
    Double temperature = Double.valueOf(mainMap.get('temp'));
    List<Object> WeatherList = (List<Object>) weatherInfoGlobal.get(
      'weather'
    );
    Map<String, Object> weatherInfo = (Map<String, Object>) WeatherList[0];
    String weatherDesc = String.valueOf(weatherInfo.get('description'));
    String dateTimeResponce = String.valueOf(weatherInfoGlobal.get('dt_txt'));

    String year = dateTimeResponce.substring(0, 4);
    String month = dateTimeResponce.substring(5, 7);
    String day = dateTimeResponce.substring(8, 10);
    String hour = dateTimeResponce.substring(11, 13);
    String minute = dateTimeResponce.substring(14, 16);
    String second = dateTimeResponce.substring(17, 19);
    String timeString = dateTimeResponce.substring(11);

    DateTime thisDate = DateTime.newInstanceGmt(
      integer.valueOf(year),
      integer.valueOf(month),
      integer.valueOf(day),
      integer.valueOf(hour),
      integer.valueOf(minute),
      integer.valueOf(second)
    );

    String[] strTimeSplit = timeString.split(':');
    Time showTime = Time.newInstance(
      Integer.valueOf(strTimeSplit[0]),
      Integer.valueOf(strTimeSplit[1]),
      0,
      0
    );

    forecast.Name = cityObj.Name; //cityFromJson +' '+ String.valueOfGmt(thisDate);
    forecast.City__c = cityObj.id;
    forecast.Temperature__c = temperature;
    forecast.Weather_message__c = 'goodi';
    forecast.Date__c = thisDate;
    forecast.Time__c = showTime;
    objList.add(forecast);
  }

  return objList;
 }
 public static City__c getChild(String responseBody) {
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
