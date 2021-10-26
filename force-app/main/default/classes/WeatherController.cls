public with sharing class WeatherController {
    @AuraEnabled
    public static List<Forecast__c> refreshWeather(String city) {
      try {
     /*   String responseBody = GetData.getResponseFromAPI(city);
  
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
          responseBody
        );*/
        CityNameIntoMap cityNameIntoMap = new CityNameIntoMap();
        Map<String, Object> responseMap = cityNameIntoMap.getMap(city);

     //  Circle circle = new Circle();
      //  List<Forecast__c> objList = circle.createCircle(responseMap);
       //    CityChild cityChild = new CityChild();
        List<Forecast__c> objList = new List<Forecast__c>();
     //   City__c cityObj = cityChild.getChild(responseBody);
        City__c cityChild = new City__c();
        Map<String,Object> cityMap = (Map<String, Object>) responseMap.get(
          'city'
        );
        String cityFromJson = String.valueOf(cityMap.get('name'));
        String countryFromJson = String.valueOf(cityMap.get('country'));
        cityChild.Country__c = countryFromJson;
        cityChild.Name = cityFromJson;
        upsert cityChild;
  
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
          String dateTimeResponce = String.valueOf(
            weatherInfoGlobal.get('dt_txt')
          );
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
          forecast.Name = cityFromJson; //cityFromJson +' '+ String.valueOfGmt(thisDate);
          forecast.City__c = cityChild.id;
          forecast.Temperature__c = temperature;
          forecast.Weather_message__c = 'goodi';
          forecast.Date__c = thisDate;
          forecast.Time__c = showTime;
          objList.add(forecast);
        }
        // objList=[select Id from Forecast__c ];*/
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
  
      //  UpsertAndSelect upsertAndSelect = new UpsertAndSelect();
     //   return upsertAndSelect.gettingWeatherMessageFromSetting(objList);
        // delete[SELECT id FROM Forecast__c];
        //  objList = [SELECT id,Temperature__c,Name,Weather_message__c,Date__c,Time__c FROM Forecast__c];
        //  return objList;
      } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
      }
    }
  }