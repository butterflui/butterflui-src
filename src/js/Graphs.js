

function BarGraph(id,prev){
	var that = this;

	this.canvas = document.createElement('canvas');
	this.canvas.setAttribute("id", id);
	this.canvas.setAttribute("class", "GraphCanvas");
	this.prevsrc = '/modules/balken_prev.pde';
	this.src = '/modules/balken2/balken2.pde';
	this.id = id;
	if (prev){
		this.pInstance = Processing.loadSketchFromSources(this.canvas, [this.prevsrc]);
		return this.canvas;
	}else{
		this.pInstance = Processing.loadSketchFromSources(this.canvas, [this.src]);

		$('#stage').append(this.canvas);
	}

	$(this.canvas).bind(that);
	$(this.canvas).mousedown(function () {
		var p = Processing.getInstanceById(this.id);
		p.setValue(800);
	});


}






