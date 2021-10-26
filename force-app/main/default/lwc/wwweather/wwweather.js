import { LightningElement } from "lwc";
//import getLastSyncDetails from '@salesforce/apex/WeatherWidgetController.getLastSyncDetails';
import refreshWeather from "@salesforce/apex/WeatherController.refreshWeather";
export default class weather extends LightningElement {
  objList;
  error;
  displayCity;
  isFormEnabled;
  configuration;

  updateValue(event) {
    let element = event.target.name;
    let value = event.target.value;
    if (element === "inputCity") {
      this.displayCity = value;
    }
  }
  handleFormSave() {
    this.handleRefresh();
  }
  connectedCallback() {
    this.EnableForme();
  }
  async EnableForme() {
    this.isFormEnabled = true;
  }
  async handleRefresh() {
    this.error = "";
    try {
      this.configuration = await refreshWeather({
        city: this.displayCity
      })
        .then((result) => {
          this.objList = result;
        })
        .catch((error) => {
          this.error = error;
        });
    } catch (error) {
      console.error(error);
      this.error = error;
    }
  }

  /*   loadBears() {
    this.isFormEnabled = true;
		refreshWeather({
            city : this.displayCity,
           
        })
			.then(result => {
                
				this.objList = result;
			})
			.catch(error => {
				this.error = error;
			});
	}*/

  catch(error) {
    console.error(error);
    this.error = error;
  }

  /*handleFormSave() {
    this.handleRefresh();
}*/

  /*  @wire(refreshWeather) forecast__cs;
    error;
    configuration;
    //apiKey;
    displayCity;
    temperature;
   weatherDescription;
    weatherIcon;
    timestamp;
    isFormEnabled;
    thisDate;
    thisTime;
  //  objList;
 /*     connectedCallback() {
        this.getLastSync();
    }
  async getLastSync() {
        this.error = '';
        try {
            this.configuration = await getLastSyncDetails();
            this.populateValues();
        }
        catch (error) {
            console.error(error);
            this.error = error;
        }
    }
*/

  /*   async handleRefresh() {
        this.error = '';
        try {
            this.configuration = await refreshWeather({
                city : this.displayCity
            });
            this.populateValues();
        }
        catch (error) {
            console.error(error);
            this.error = error;
        }
    }
    populateValues() {
        const configuration = this.configuration;
        this.isFormEnabled = false;
      //  this.objList=this.objList;
       // if(configuration) {
        for (var i = 0; i < forecast__cs.length; i++) { 
           this.displayCity = configuration.City__c;
            this.temperature = configuration.Temperature__c;
          this.weatherDescription = configuration.Weather_message__c;
       }
         
        }
      // else {
      //     this.isFormEnabled = true;
     //   }
    
    updateValue(event) {
        let element = event.target.name;
        let value = event.target.value;
        if(element === 'inputCity') {
            this.displayCity = value;
        }
     /*   if(element === 'inputApiKey') {
            if(value !== '') {
                this.apiKey = value;
            }
        }*/
  /*  }
    handleFormSave() {
        this.handleRefresh();
    }
    handleEdit() {
        this.isFormEnabled = true;
    }
    handleCancel() {
        this.isFormEnabled = false;
    }
}*/
}