//Open New Graph Menue Listener
newGraphMenue.listen();




$('.testCanvas').draggable();
$('#eingabe').draggable();

getUIWindow();


disableDblClick("#eingabe");





function disableDblClick(elementName) {
	$(elementName).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
	});
}


