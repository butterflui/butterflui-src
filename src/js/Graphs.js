function Graph() {
	this.threshold = 100;
	this.max = false;
	this.min = false;
	this.name = "Name";
	this.color = "#fdddff";
	this.prevsrc = '';
	this.src = '';
}


var BarGraph = function (){
	prevsrc = '/modules/balken_prev.pde';
	src = '/modules/balken.pde';
};
BarGraph.prototype = new Graph();
BarGraph.threshold = 300;


var ToggleGraph = function () {
	prevsrc = '/modules/balken_prev.pde';
	src = '/modules/balken.pde';
};
ToggleGraph.prototype = new Graph();


var CircleGraph = function () {
	prevsrc = '/modules/balken_prev.pde';
	src = '/modules/balken.pde';
};