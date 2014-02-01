//Open New Graph Menue Listener
newGraphMenue.listen();

setMode("work");
ModeSelectListener();

$('.testCanvas').draggable();
$('#eingabe').draggable();


$('#testInput').click(function(){
	event.stopPropagation();
	event.preventDefault();
	
	


});



getUIWindow();


disableDblClick("#eingabe");




function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		setMode(this);
	});

}






