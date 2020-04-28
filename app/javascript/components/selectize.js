import 'tail.select/js/tail.select-full.min.js';
import 'tail.select/css/bootstrap4/tail.select-default.min.css';

const tail = () => {
  $('select').selectize({
      sortField: 'text'
  });
};

document.addEventListener("DOMContentLoaded", function(){
  tail.select("select", { /* Your Options */ });
});

export { selectize };