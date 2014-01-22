function newGraphMenu(e) {


	
	var GraphMenue = $("<div/>", {"class":"ListWindow"});
	var GraphMenueIn = $('<ul><li><a href="#" class="ListWindowLink">Arduino</a></li></ul><ul><li><a href="#" class="ListWindowLink">Int myInt</a></li><li><a href="#" class="ListWindowLink">Boolean myBool</a></li><li><a href="#" class="ListWindowLink">Float myFloat</a></li></ul>');

	$(GraphMenueIn).appendTo(GraphMenue)
	$("#stage").append(GraphMenue);
	$(GraphMenue).offset({top:e.pageY, left:e.pageX});
	
	//close ListWindow by single click on Stage
	$("#stage").click(function(event) {

		$(GraphMenue).remove();
	});

	//open second Window
	$(".ListWindow a").click(function(event) {
		event.preventDefault();
		event.stopPropagation();
		$(this).toggleClass('active');

		if($(this).attr('class') == "ListWindowVar")
		showGraphView(event);
		
	});

	$(GraphMenue).dblclick(function(event) {
		event.preventDefault();
		event.stopPropagation();
	});


	function showGraphView(e, positionX, positionY) {
		var GraphView = $("<div/>",{"class":"ListWindow"});
		var GraphViewIn = $("")

		$(GraphViewIn).appendTo(GraphView);
		$("#stage").append(GraphView);
		$(GraphView).offset({left:positionX, top:positionY});
	}
}