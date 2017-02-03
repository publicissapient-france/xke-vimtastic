function findByCity(obj, searchVal) {
  const searchField = 'COM';
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
    return `<div><h3>${result.TICO} - ${result.COM}</h3><p>${result.PPRO}</p></div>`;
  }).join('');
  return `<p>Found ${results.length} monument${results.length > 1 ? 's' : ''}</p>${monumentsHtml}`;
}

module.exports = {
  findByCity,
  toHtml,
};
