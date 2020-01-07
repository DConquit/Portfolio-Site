$(document).ready(function() {
    $("#aboutme").click( function() {
        $(".window").addClass("hidden");
        $("#personalinfo").removeClass("hidden");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#aboutme p").css("border-color", "white");
    })

    $("#resume").click( function() {
        $(".window").addClass("hidden");
        $("#resumeexplorer").removeClass("hidden");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#resume p").css("border-color", "white");
    })

    $("#projectfolder").click( function() {
        $(".window").addClass("hidden");
        $("#projectswindow").removeClass("hidden");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#projectfolder p").css("border-color", "white");
    })
    $("#github").click( function() {
        window.open("https://github.com/DConquit");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#github p").css("border-color", "white");
    })
    $("#email").click( function() {
        window.location.href = "mailto:dconquit@gmail.com";
        $(".deskobject p").css("border-color", "#7a3045");
        $("#email p").css("border-color", "white");
    })
    $("#settings").click( function() {
        $(".window").addClass("hidden");
        $("#settingswindow").removeClass("hidden");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#settings p").css("border-color", "white");
    })
    $("#meteoroids").click( function() {
        $(".window").addClass("hidden");
        $("#meteoroidswindow").removeClass("hidden");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#meteoroids p").css("border-color", "white");
    })
    $("#meteorsource").click( function() {
        window.open("https://github.com/DConquit/Meteoroids");
        $(".deskobject p").css("border-color", "#7a3045");
        $(".folderobject p").css("border-color", "white");
        $("#meteorsource p").css("border-color", "#2e222f");
    })

})

