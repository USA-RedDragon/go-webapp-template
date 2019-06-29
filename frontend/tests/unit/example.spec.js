import { expect } from "chai";
import { shallowMount } from "@vue/test-utils";
import HelloWorld from "@/components/HelloWorld.vue";

describe("HelloWorld.vue", () => {
  it("renders", () => {
    const msg = "Welcome to Vuetify";
    const wrapper = shallowMount(HelloWorld);
    expect(wrapper.text()).to.include(msg);
  });
});
