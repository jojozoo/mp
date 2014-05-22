$(function(){
	$(document).on('click', '.droplink', function(){
		$(".uploadfile").click();
	});
	$(".drag-info").dropzone({
        url: "handle-upload.php",
        addRemoveLinks: true,
        dictRemoveLinks: "O",
        dictCancelUpload: "x",
        maxFiles: 10,
        maxFilesize: 20,
        acceptedFiles: "images/*",
        init: function() {
            this.on("success", function(file) {
                console.log("File " + file.name + "uploaded");
            });
            this.on("removedfile", function(file) {
                console.log("F.jsile " + file.name + "removed");
            });
        }
    });
})
// $("div.drag-info").dropzone({ url: "/file/post" });