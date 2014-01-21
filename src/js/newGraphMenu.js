function newGraphMenu(e) {
	
	var GraphMenue = $("<div/>", {"class":"ListWindow"});
	var GraphMenueIn = $('<ul><li><a href="#">Arduino</a></li></ul><ul><li><a href="#">Int myInt</a></li><li><a href="#">Boolean myBool</a></li><li><a href="#">Float myFloat</a></li></ul>');

	$(GraphMenueIn).appendTo(GraphMenue)
	$("#stage").append(GraphMenue);
	$(GraphMenue).offset({top:e.pageY, left:e.pageX});
	
	$("#stage").click(function(event) {
		$(GraphMenue).remove();
	});

}