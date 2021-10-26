public class TestDataFactory {
  public static List<Forecast__c> createForecasts(
    Integer numFrcsts,
    String name,
    Integer temperature
  ) {
    Weather_Setting__c setting = Weather_Setting__c.getInstance();
    List<Forecast__c> forecasts = new List<Forecast__c>();
    City__c city = new City__c();
    insert city;
    for (Integer i = 0; i < numFrcsts; i++) {
      Forecast__c a = new Forecast__c(
        Name = name + i,
        City__c = city.Id,
        Temperature__c = temperature
      );
      forecasts.add(a);
    }
    insert forecasts;
    return forecasts;
  }
}