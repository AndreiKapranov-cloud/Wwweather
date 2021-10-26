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

  

  catch(error) {
    console.error(error);
    this.error = error;
  }


}
