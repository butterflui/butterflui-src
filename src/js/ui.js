//Open New Graph Menue Listener
newGraphMenue.listen();

setMode("work");
ModeSelectListener();


var socket = io.connect('http://localhost');
  socket.on('analogRead', function (data) {
    console.log(data);
    
  });


getUIWindow();


disableDblClick("#eingabe");




function ModeSelectListener() {
	
	$('#ModeSelect a').click(function(){
		setMode(this);
	});

}







