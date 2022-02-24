import fs from 'fs';
import config from '../config.js';

export type Banner = {
  imageUrl: string;
  index: number;
};

export type BannerBundle = {
  bannersCount: number;
  banners: Array<Banner>;
  updatedAt: Date;
};

let datas: BannerBundle;

export async function getAllBanner(): Promise<BannerBundle> {
  return datas;
}

function updateData() {
  fs.readdir(config.static.url + '/banner', (_err, files) => {
    let banners: Array<Banner> = [];
    files.forEach((fileString) => {
      let fileUrl = config.server.baseUrl + '/banner/' + fileString;
      let data: Banner = {
        imageUrl: fileUrl,
        index: 1,
      };
      banners.push(data);
    });
    let bundle: BannerBundle = {
      bannersCount: banners.length,
      banners: banners,
      updatedAt: new Date(),
    };
    datas = bundle;
  });
}
updateData();
