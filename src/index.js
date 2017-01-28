const path = require('path');
const fs = require('fs');
const express = require('express');

const app = express();

let monuments;

fs.readFile(path.join(__dirname, '/data/firstHundred.json'), { encoding: 'utf-8' }, (err, data) => {
  if (!err) {
    monuments = JSON.parse(data);
    console.log(`Loaded ${monuments.length} monuments`);
  } else {
    console.log(err);
  }
});

function findByRegion(obj, searchVal) {
  const searchField = 'REG';
  const results = [];
  if (searchVal.length > 0) {
    for (let i = 0; i < obj.length; i++) {
      if (obj[i][searchField] && obj[i][searchField].toLowerCase().indexOf(searchVal.toLowerCase()) !== -1) {
        results.push(obj[i]);
      }
    }
  }
  return results;
}

function toHtml(results) {
  const monumentsHtml = results.map((result) => {
    return `<div><h3>${result.TICO} - ${result.REG}</h3><p>${result.PPRO}</p></div>`;
  }).join('');
  return `<p>Found ${results.length} monument${results.length > 1 ? 's' : ''}</p>${monumentsHtml}`;
}

app.get('/api/search', (req, res) => {
  res.send(toHtml(findByRegion(monuments, req.query.q)));
});

app.use(express.static(path.join(__dirname, '/public')));

app.listen(3000, () => {
  console.log('Server running!');
});

