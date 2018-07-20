(function(){
  document.addEventListener('DOMContentLoaded', function() {
    var checkedList = document.querySelectorAll('input[id^="playlist_ids_ids_"]')

    checkedList.forEach(function(checkedItem){
      checkedItem.addEventListener('click', addShadowToParentCard);
    })
  }, false);

  function addShadowToParentCard(event){
    if (this.checked){
      var card = this.parentElement
      card.setAttribute('class', 'p-card--highlighted col-2');
    } else  {
      var card = this.parentElement
      card.setAttribute('class', 'p-card col-2');
    }
  }
})();