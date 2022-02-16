export type Post = {
  id: string;
  title: string;
  content: string;
  createdAt: Date;
  userId: string;
};
export type Posts = Post[];
type InputPost = {
  title: string;
  content: string;
  userId: string;
};

let posts: Posts = [
  {
    id: '1',
    title: 'sample post',
    content: 'Hello world!',
    createdAt: new Date(),
    userId: '1',
  },
  {
    id: '2',
    title: 'hello everyone',
    content: 'Hello world!',
    createdAt: new Date(),
    userId: '1',
  },
  {
    id: '3',
    title: 'wow!',
    content: 'Hello world!aasd',
    createdAt: new Date(),
    userId: '1',
  },
];

function sortPosts(): void {
  posts = posts.sort((a, b) => Number(b.createdAt) - Number(a.createdAt));
}
sortPosts();

export async function create(post: InputPost): Promise<string> {
  sortPosts();
  const created: Post = { ...post, createdAt: new Date(), id: Date.now().toString() };
  posts.push(created);
  return created.id;
}

export async function findById(id: string) {
  return posts.find((post) => post.id === id);
}

// export async function findByUserId(userId) {
//   let postArray;
//   postArray = posts.filter((post) => post.userId === userId);
//   return postArray;
// }

// export async function findByIdAndDelete(id) {
//   posts = posts.filter((post) => post.id !== id);
// }

export async function getAllPosts(): Promise<Posts> {
  return posts;
}

export async function getPosts(start: number, range: number): Promise<Posts> {
  return posts.slice(start, range + start);
}
// export async function update(id, data) {
//   const post = posts.find((post) => post.id === id);
//   console.log(post);
//   if (!post) {
//     return false;
//   }
//   post.title = data.title;
//   post.content = data.content;
//   return post;
// }

for (let i = 0; i < 1200; i++) {
  const created = {
    id: String(i + 4),
    title: 'sample',
    content: 'ssss',
    userId: '1',
    createdAt: new Date('2019-05-25'),
  };
  posts.push(created);
}
