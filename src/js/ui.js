// Call New Graph Menue
$('#stage').dblclick(function(event) {
		
    newGraphMenu(event);
});




$('.testCanvas').draggable();
$('#eingabe').draggable();




disableDblClick("#eingabe");

function disableDblClick(elementName) {
	$(elementName).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
	});
}


