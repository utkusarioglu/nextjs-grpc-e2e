const { describeName } = require("../utils/test.utils");

const url = "/";
const pages = ["gRPC"];
const links = ["Grafana", "Jaeger", "Prometheus"];

Cypress.env().viewportSizes.forEach((viewportSize) => {
  describe(describeName(Cypress, viewportSize, "navigation"), () => {
    beforeEach(() => {
      cy.viewport(...viewportSize);
      cy.visit(url);
    });

    it("Should contain expected links", () => {
      cy.screenshot();
      [...pages, ...links].forEach((link) => {
        cy.contains(link);
      });
    });

    pages.forEach((page) => {
      it(`Should navigate to ${page} page`, () => {
        cy.contains(page).click();
        cy.wait(5000);
        cy.screenshot();
      });
    });

    links.forEach((link) => {
      it(`Should contain ${link} link`, () => {
        cy.contains(link).should("contain", link);
      });
    });
  });
});
