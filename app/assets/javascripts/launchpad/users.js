$(document).ready(function() {
	
	// table sorting http://tablesorter.com/docs/
	
	$("#tablesorter").tablesorter(); 
	$("#tablesorter_users").tablesorter( {sortList: [[2,0]], headers: { 0: { sorter: false}, 1: {sorter: false}, 6: {sorter: false} }}); 
	$("#tablesorter_orders").tablesorter( {sortList: [[0,0]], headers: { 7: { sorter: false}, 8: {sorter: false}}} ); 
	
	return $("input.datepicker").each(function(i) {
	    return $(this).datepicker({
	      altFormat: "yy-mm-dd",
	      dateFormat: "mm/dd/yy",
	      altField: $(this).next()
	    });
	});
	
})