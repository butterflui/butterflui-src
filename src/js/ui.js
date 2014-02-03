//Open New Graph Menue Listener
newGraphMenue.listen();

setMode("work");
ModeSelectListener();





getUIWindow();


disableDblClick("#eingabe");




function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		setMode(this);
	});

}







