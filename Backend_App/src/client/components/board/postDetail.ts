import { TPostDetail } from '../../clientType/clientType.js';
import * as global from '../../global.js';

export class PostDetail {
  constructor(private postId: string) {}

  async fetchData(): Promise<TPostDetail> {
    return await global.boardPage.getPost(this.postId);
  }

  async render() {
    const data = await this.fetchData();
    const post = data.post;
    const user = { username: data.username, name: data.name, id: data.post.userId };

    //todo: updateBtn, deleteBtn, user디테일 링크
    return `<div class="post__set">
  		<div class="post__title">${post.title}</div>
  		<div class="post__info">
  			<div class="post__auth">
  				<a href="/users/${user.id}">${user.name}</a> |
  			</div>
  			<div class="post__date">${post.createdAt.toLocaleString()}</div>
  		</div>
  		<div class="post__content">${post.content}</div>
  	</div>`;
  }
}
