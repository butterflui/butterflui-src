//Open New Graph Menue Listener
newGraphMenue.listen();

setMode("work");
ModeSelectListener();

$('.testCanvas').draggable();
$('#eingabe').draggable();






getUIWindow();


disableDblClick("#eingabe");




function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		setMode(this);
	});

}






