function newGraphMenu(e) {

	var toggleWindow2 = 0;
	
	var GraphMenue = $("<div/>", {"class":"ListWindow"});
	var GraphMenueIn = $('<ul><li><a href="#" class="ListWindowArd">Arduino</a></li></ul><ul><li><a href="#" class="ListWindowVar">Int myInt</a></li><li><a href="#" class="ListWindowVar">Boolean myBool</a></li><li><a href="#" class="ListWindowVar">Float myFloat</a></li></ul>');
	$(GraphMenueIn).appendTo(GraphMenue)

	var ArdView = $("<div/>",{"class":"ListWindow"});
	var ArdViewIn = $('<span>test</span>');
	$(ArdViewIn).appendTo(ArdView);

	var GraphView = $("<div/>",{"class":"ListWindow"});
	var GraphViewIn = $('<span>vars</span>')
	$(GraphViewIn).appendTo(GraphView);

	
	$("#stage").append(GraphMenue);
	$(GraphMenue).offset({top:e.pageY, left:e.pageX});
	
	//close ListWindow by single click on Stage
	closeWindowHandler(GraphMenue);

	//open second Window
	$(".ListWindow a").click(function(event) {
		event.preventDefault();
		event.stopPropagation();
		$(this).toggleClass('active');

		console.log($(this).attr('class'));

		if ($(".ListWindow .active").length == 0) {
			$(ArdView).remove();
			$(GraphView).remove();
			toggleWindow2 = 0;
		};

		if($(this).attr('class') == "ListWindowVar active"){


			switch(toggleWindow2)
			{
				case 0:
				showGraphView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
				toggleWindow2 = 1;
				break;

				case 1:
				
				break;

				case 2:
				$(ArdView).remove();
				$(".ListWindowArd").removeClass('active');
				showGraphView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
				toggleWindow2 = 1;
				break;
			}

		};

		if($(this).attr('class') == "ListWindowArd active"){
			switch(toggleWindow2)
			{
				case 0:
				showArdView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
				toggleWindow2 = 2;
				break;

				case 1:
				$(GraphView).remove();
				$(".ListWindowVar").removeClass('active');
				showArdView(event,e.pageX+$(GraphMenue).width()+1,e.pageY);
				toggleWindow2 = 2
				break;

				case 2:
				break;
			}
		
	}
		
	});

	disableDblClick(GraphMenue);

	//Show Graph Selector Window
	function showGraphView(e, positionX, positionY) {
		
		
		
		$("#stage").append(GraphView);
		$(GraphView).offset({left:positionX, top:positionY});

		closeWindowHandler(GraphView);
		
	}
	//Show Arduino Pin Selector Window
	function showArdView(e, positionX, positionY) {
		
		$("#stage").append(ArdView);
		$(ArdView).offset({left:positionX, top:positionY});

		closeWindowHandler(ArdView);
		
	}


	// Remove Window if click on stage
	function closeWindowHandler (windowId) {

		$("#stage").click(function(event) {
		$(windowId).remove();
	});
	}
}