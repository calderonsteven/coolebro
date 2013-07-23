var oMap = new GMap2(document.getElementById("map"));	

//variables and options for flickr API
var photoset_id = "72157633000512213";
var api_key = "131b5631646993095514ab60548676f1";
var extras = "date_upload%2C+date_taken%2C+owner_name%2C+icon_server%2C+original_format%2C+last_update%2C+geo%2C+tags%2C+machine_tags%2C+o_dims%2C+views%2C+media%2C+path_alias%2C+url_sq%2C+url_t%2C+url_s%2C+url_q%2C+url_m%2C+url_n%2C+url_z%2C+url_c%2C+url_l%2C+url_o";
var urlPhotoset = "http://api.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key="+api_key+"&photoset_id="+photoset_id+"&extras="+extras+"&format=json&callback=?";

console.log(urlPhotoset);

//Call the flickr.photosets.getPhotos via ajax
$.getJSON(urlPhotoset);

//callback function for $.getJSON(urlPhotoset);
function jsonFlickrApi(rsp){
	if(!rsp.photoset){ return; }

	//add each image in map and add in the photo lists
	$.each(rsp.photoset.photo, function(i,item){
		//console.log(item);

		//put in map
		putInMap(item);

		//append the new image
		$("#images").append('<li><img class="img-rounded" src="'+item.url_m+'" data-lat="'+item.latitude+'" data-lon="'+item.longitude+'" /></li>');				
	});

	//add event for center map
	$("#images img").click(function(){				
		//re center on click image
		var lat = $(this).data("lat");
		var lon = $(this).data("lon");
		oMap.setCenter(new GLatLng(lat, lon), 13);
	});
}	

//add photo to map
function putInMap(photo){
	//console.log(photo.latitude, photo.longitude);  

	// center the google map and add a marker
	oMap.setCenter(new GLatLng(photo.latitude, photo.longitude), 13);  
	var oMarker = new GMarker(new GLatLng(photo.latitude, photo.longitude));  
	oMap.addOverlay(oMarker);
}