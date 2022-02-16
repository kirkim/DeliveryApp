export interface Component {
  render(parent: HTMLElement): void;
  attachTo(parent: HTMLElement, position: InsertPosition): void;
}

export class BaseComponent<T extends HTMLElement> implements Component {
  protected readonly element: T;

  constructor(htmlString: string) {
    const template = document.createElement('template');
    template.innerHTML = htmlString;
    this.element = template.content.firstElementChild! as T;
  }

  attachTo(parent: HTMLElement, position: InsertPosition = 'afterbegin') {
    parent.insertAdjacentElement(position, this.element);
  }

  render(parent: HTMLElement) {
    if (parent.childNodes[0]) {
      parent.replaceChild(this.element, parent.childNodes[0]);
    } else {
      parent.appendChild(this.element);
    }
  }
}
