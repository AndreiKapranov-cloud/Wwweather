trigger ForecastMessage on Forecast__c(before insert) {
  Weather_Setting__c setting = Weather_Setting__c.getInstance();
  for (Forecast__c a : Trigger.New) {
    if (a.Temperature__c > setting.Upper_Limit__c) {
      a.Weather_Message__c = setting.Upper_Limit_Message__c;
    } else if (a.Temperature__c < setting.Lower_Limit__c) {
      a.Weather_Message__c = setting.Lower_Limit_Message__c;
    } else {
      a.Weather_Message__c = setting.Normal_Level_Message__c;
    }
  }
}