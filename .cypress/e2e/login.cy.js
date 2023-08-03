const { describeName } = require("../utils/test.utils");

const URL = "/login";

Cypress.env().viewportSizes.forEach((viewportSize) => {
  describe(describeName(Cypress, viewportSize, "navigation"), () => {
    describe("keywords", () => {
      beforeEach(() => {
        cy.viewport(...viewportSize);
        cy.visit(URL);
      });

      [
        {
          keyword: "error",
          message: "Something went wrong",
        },
        {
          keyword: "wrong",
          message: "Wrong username or password",
        },
        {
          keyword: "guest",
          message: "Success",
        },
      ].forEach(({ keyword, message }) => {
        it(`Should return "${keyword}" response`, () => {
          cy.get("#username").click().type(keyword);
          cy.get("#password").click().type(keyword);
          cy.get("button[type=submit]").click();
          cy.contains(message);
          cy.wait(10e3);
          cy.screenshot(`after "${keyword}" submit`);
        });
      });
    });
  });
});
