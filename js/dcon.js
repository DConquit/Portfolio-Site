$(document).ready(function() {
    $("#aboutme").click( function() {
        $(".window").addClass("hidden");
        $("#personalinfo").removeClass("hidden");
    })

    $("#resume").click( function() {
        $(".window").addClass("hidden");
        $("#resumeexplorer").removeClass("hidden");
    })

    $("#projectfolder").click( function() {
        $(".window").addClass("hidden");
        $("#projectswindow").removeClass("hidden");
    })
    $("#github").click( function() {
        window.open("https://github.com/DConquit");
    })

})

