trigger DelForecast on Forecast__c(before insert) {
  List<String> names = new List<String>();
  for (Forecast__c a : Trigger.New) {
    names.add(a.Name);
  }
  List<Forecast__c> deleteList = [
    SELECT Id
    FROM Forecast__c
    WHERE Name IN :names
  ];
  delete deletelist;
}