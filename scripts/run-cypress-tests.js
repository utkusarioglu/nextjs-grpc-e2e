#! /usr/local/bin/node
const cypress = require("cypress");
const {
  getE2eBrowsers,
  getE2eViewportSizes,
  getE2eVideoPaddings,
  calculateE2eWindowSize,
} = require("../cypress/utils/test.utils.js");
const config = require("../cypress.config.js");

const browsers = getE2eBrowsers();
const viewportSizes = getE2eViewportSizes();
const videoPadding = getE2eVideoPaddings();
const windowSize = calculateE2eWindowSize(viewportSizes, videoPadding);

browsers
  .reduce((chain, browser) => {
    chain = chain.then((prevResults) => {
      console.log(`Starting: ${browser}`);
      return cypress
        .run({
          browser,
          config: {
            ...config,
            env: {
              ...config.env,
              windowSize,
              viewportSizes,
              browsers,
            },
            screenshotsFolder: `cypress/artifacts/${browser}/screenshots`,
            videosFolder: `cypress/artifacts/${browser}/videos`,
          },
        })
        .then((result) => ({ ...prevResults, [browser]: result }));
    });
    return chain;
  }, Promise.resolve({}))
  .then((results) => {
    const failures = Object.values(results).reduce(
      (prev, { totalFailed }) => prev + totalFailed,
      0
    );
    if (failures) {
      console.log(`There are ${failures} failures in Cypress E2E tests.`);
      process.exit(failures);
    }
  });
