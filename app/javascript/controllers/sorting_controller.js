import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["exchangeEvents"];

  initialize() {
    this.observer = new MutationObserver(this.sortChildren.bind(this));
    this.observer.observe(this.exchangeEventsTarget, {
      childList: true,
      subtree: true,
    });
  }

  // Private

  sortChildren() {
    const { children } = this;
    if (elementsAreSorted(children)) return;
    this.observer.disconnect();

    children.sort(compareElements).forEach(this.append);

    this.observer.observe(this.element, {
      childList: true,
      subtree: true,
    });
  }

  get children() {
    return Array.from(this.element.children);
  }

  append = (child) => {
    this.element.append(child);
  };
}

function elementsAreSorted([left, ...rights]) {
  for (const right of rights) {
    if (compareElements(left, right) > 0) return false;
    left = right;
  }
  return true;
}

function compareElements(left, right) {
  return getSortCode(right) - getSortCode(left);
}

function getSortCode(element) {
  return element.getAttribute("data-sort-code") || 0;
}
