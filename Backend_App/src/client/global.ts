import BoardPage from './service/board.js';
import HttpClient from './network/http.js';

const baseURL = `http://localhost:8080`;
const httpClient = new HttpClient(baseURL);
export const boardPage = new BoardPage(httpClient);
