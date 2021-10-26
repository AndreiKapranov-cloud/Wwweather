@isTest
public class TestDelForecast {
    @isTest
    static void TestDeleteForecastsWithEqualNames() {
        City__c city = new City__c();
        insert city;
        List<Forecast__c> forecastsFirst = TestDataFactory.createForecasts(
            1,
            'Paris',
            45
        );
        List<Forecast__c> forecastsSecond = TestDataFactory.createForecasts(
            2,
            'jhhvkg',
            -50
        );
        Test.startTest();
        try {
           
            List<Forecast__c> accts = weatherController.refreshWeather('Paris');
        } catch (exception e) {
        }
        Test.stopTest();
    }
}