import { BoardList } from './components/board/boardList.js';
import * as global from './global.js';
import { BaseComponent } from './components/components.js';

const openBoardPageBtn = document.querySelector('#nav-board')! as HTMLButtonElement;
const main = document.querySelector('.document')! as HTMLDivElement;

async function openBoardPage() {
  const data = await global.boardPage.getBoard();
  const boardList = new BoardList(data);
  const board = new BaseComponent(boardList.render());
  board.render(main);
  const titleLink = document.querySelector('main')! as HTMLUListElement;
  titleLink.addEventListener('click', async (event) => {
    const data = new BaseComponent(await boardList.onWatchPostListener(event));
    data.render(main);
  });
}

openBoardPageBtn.addEventListener('click', openBoardPage);
