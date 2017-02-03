const path = require('path');
const fs = require('fs');
const express = require('express');

const { findByCity, toHtml } = require('./monuments');

const app = express();

let monumentData;

fs.readFile(path.join(__dirname, '/data/firstHundred.json'), { encoding: 'utf-8' }, (err, data) => {
  if (!err) {
    monumentData = JSON.parse(data);
    console.log(`Loaded ${monumentData.length} monuments`);
  } else {
    console.log(err);
  }
});

app.get('/api/search', (req, res) => {
  res.send(toHtml(findByCity(monumentData, req.query.q)));
});

app.use(express.static(path.join(__dirname, '/public')));

app.listen(3000, () => {
  console.log('Server running!');
});

