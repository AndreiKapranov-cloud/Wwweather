import { createElement } from "lwc";
import weather from "c/weather";
import refreshWeather from "@salesforce/apex/WeatherController.refreshWeather";


jest.mock(
  "@salesforce/apex/WeatherController.refreshWeather",
  () => {
    return {
      default: jest.fn()
    };
  },
  { virtual: true }
);


const DATA = [
  {
    City__c: "a05N000000BGZIAIA5",
    Date__c: "2021-10-24T21:00:00.000Z",
    Id: "a01N000000N0F2eIAF",
    Name: "London",
    Temperature__c: 13.19,
    Time__c: 75600000,
    Weather_message__c: "Work."
  },
  {
    City__c: "a05N000000BGZIAIA5",
    Date__c: "2021-10-25T00:00:00.000Z",
    Id: "a01N000000N0F2fIAF",
    Name: "London",
    Temperature__c: 12.45,
    Time__c: 0,
    Weather_message__c: "Work."
  }
];

const APEX_ERROR = {
  body: { message: "An internal server error has occurred" },
  ok: false,
  status: 400,
  statusText: "Bad Request"
};

describe("c-weather", () => {
  afterEach(() => {
    
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
s
    jest.clearAllMocks();
  });

 
  async function flushPromises() {
    return Promise.resolve();
  }

  it("compare ", async () => {
    
    refreshWeather.mockResolvedValue(DATA);

    // Create initial element
    const element = createElement("c-weather", {
      is: weather
    });
    document.body.appendChild(element);

    
    const buttonEl = element.shadowRoot.querySelector("lightning-button");
    buttonEl.click();

   
    await flushPromises();

    const detailEls = element.shadowRoot.querySelectorAll("p");
   
    expect(detailEls[0].textContent).toBe(DATA[0].Id);
    expect(detailEls[1].textContent).toBe(DATA[0].Name);
  });

  it("renders the error", async () => {
   
    refreshWeather.mockRejectedValue(APEX_ERROR);

   
    const element = createElement("c-weather", {
      is: weather
    });
    document.body.appendChild(element);

   
    const buttonEl = element.shadowRoot.querySelector("lightning-button");
    buttonEl.click();

    
    await flushPromises();

    const errorPanelEl = element.shadowRoot.querySelector(
      "div.slds-text-color_error"
    );
    expect(errorPanelEl).not.toBeNull();
  });
});
