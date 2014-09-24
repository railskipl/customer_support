function prepareList() {
  $('#expList').find('li:has(ul)')
  	.click( function(event) {
  		if (this == event.target) {
  			$(this).toggleClass('expanded');
  			$(this).children('ul').slideToggle(500);
  		}

  		return false;
  	})
  	.addClass('collapsed')
  	.children('ul').hide();
  };

  $(document).ready( function() {
      prepareList()
  });
