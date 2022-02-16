import { TPostDetail, TPosts } from '../clientType/clientType';
import HttpClient from '../network/http';

export default class BoardPage {
  constructor(private http: HttpClient) {}

  async getBoard(): Promise<TPosts> {
    const data = await this.http.fetch(`/board`, {
      method: 'GET',
    });
    return data;
  }

  async getPost(id: string): Promise<TPostDetail> {
    const data = await this.http.fetch(`/board/view?no=${id}`, {
      method: 'GET',
    });
    return data;
  }
}
