// Call New Graph Menue
$('#stage').dblclick(function(event) {
		
    newGraphMenu(event);
});



$('.testCanvas').draggable();



disableDblClick("#eingabe");

function disableDblClick(elementName) {
	$(elementName).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
		console.log("das geht");
	});
}