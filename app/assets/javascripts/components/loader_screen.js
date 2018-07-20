(function(){
  document.addEventListener('DOMContentLoaded', function() {
    var shareButtons = document.querySelectorAll('.share_button')

    shareButtons.forEach(function(btn){
      btn.addEventListener('click', showSpinner);
    })
  }, false);

  function showSpinner(event){
    window.scrollTo(0, 0);
    document.querySelector('.loader_screen').setAttribute('class', 'visible loader_screen')
  }
})();