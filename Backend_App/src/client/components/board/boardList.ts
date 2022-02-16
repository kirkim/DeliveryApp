import { PostDetail } from './postDetail.js';
import { TPosts } from '../../clientType/clientType.js';

export class BoardList {
  constructor(private data: TPosts) {
    this.render();
  }

  onWatchPostListener(event: Event) {
    const target = event.target as HTMLElement;
    if (target.dataset.id) {
      const detail = new PostDetail(target.dataset.id);
      return detail.render();
    }
    return '';
  }
  render() {
    let render = '';
    this.data.forEach((post) => {
      const title = `<div class="board-title"><span data-id="${post.id}">${post.title}</span></div>`;
      render = render + `<li>${title}</li>`;
    });
    return `<ul>${render}</ul>`;
  }
}
