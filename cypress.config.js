require("dotenv").config();
const { defineConfig } = require("cypress");

const baseUrl = `https://${process.env.BASE_URL}`;

module.exports = defineConfig({
  e2e: {
    supportFile: false,
    baseUrl,
    setupNodeEvents(on, config) {
      console.log("Using cypress config:\n", JSON.stringify(config));

      const windowSize = config.env.windowSize;
      on("before:browser:launch", (browser = {}, launchOptions) => {
        if (browser.isHeadless) {
          switch (browser.name) {
            case "electron":
              launchOptions.preferences["width"] = windowSize[0];
              launchOptions.preferences["height"] = windowSize[1];
              launchOptions.preferences["resizable"] = false;
              break;
            case "chrome":
            case "edge":
              launchOptions.args.push(`--window-size=${windowSize.join(",")}`);
              break;
            case "firefox":
              launchOptions.args.push(`--width=${windowSize[0]}`);
              launchOptions.args.push(`--height=${windowSize[1]}`);
              break;
            default:
              throw new Error(`Unrecognized browser: ${browser.name}`);
          }
          return launchOptions;
        }
      });
    },
  },

  videoCompression: false,
});
