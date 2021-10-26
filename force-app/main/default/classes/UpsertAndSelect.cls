public with sharing class UpsertAndSelect {
      public List<Forecast__c>  gettingWeatherMessageFromSetting(List<Forecast__c> objList){
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
}
