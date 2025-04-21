import { LightningElement } from "lwc";

export default class WheelOfNames extends LightningElement {
  connectedCallback() {
    console.log("Welcome to Wheel of Names! Spin the wheen if you dare!");
  }

  renderedCallback() {
    let wheel = this.template.getElementById("#bottomInstruction");

    console.log(wheel);

    // this.wheel.addEventListener("click", (event) => {
    //     console.log('Wheel of Names was clicked!' + event);
    //   });
  }
}
