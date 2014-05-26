$(function(){
	$(".active-photo-wrap").dropzone({
		url: "handle-upload.php",
		maxFiles: 10,
		maxFilesize: 20
	});
})