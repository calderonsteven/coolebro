function jsHelper() {
  var height = 0;
  var width = 0;
  
  this.width = $("#coolebro").parent().width();
  this.height = $("#coolebro").parent().height();
  
  this.printSizeParent = function(){
    console.log(width, height);
  }
  
  return this;
}
  

