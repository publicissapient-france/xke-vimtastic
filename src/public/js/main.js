      const filterInput = document.querySelector('input');
      const loader = document.querySelector('.loader');
      const results = document.querySelector('.results');

      function filter(e) {
          if (e.target.value.length > 1) {
              loader.style.display = 'inline';
              axios.get('/api/search?q=' + e.target.value).then((res) => {
                  loader.style.display = 'none';
                  results.innerHTML = res.data;
              });
          }
      }

      const debouncedFilter = _.debounce(filter, 300);
      filterInput.addEventListener('keyup', debouncedFilter);
