import { promises as fs } from 'fs';
import https from 'https';

const [, , oldFile, newFile] = process.argv;

let json = JSON.parse(await fs.readFile(oldFile, 'utf8'));
let webreqs = {};

for (const [pkg, pkgData] of Object.entries(json.packages)) {
  let {resolved, link, integrity, version, name} = pkgData;

  if (resolved && (link || integrity))
    continue;
  if (!pkg.startsWith('node_modules/'))
    continue;

  name = name || pkg.replace(/.*node_modules\//, '')

  webreqs[pkg] = new Promise(resolve =>
    https.get(`https://registry.npmjs.org/${name}/${version}`,
    res => {
      let body = "";
      res.on("data", c => body += c);
      res.on("end", () => resolve(JSON.parse(body)));
    })
  );
}

for (const [pkg, res] of Object.entries(webreqs)) {
  const response = await res;
  json.packages[pkg].resolved = response.dist.tarball;
  json.packages[pkg].integrity = response.dist.integrity;
};

await fs.writeFile(newFile, JSON.stringify(json, null, 2));
