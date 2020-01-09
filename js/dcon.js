$(document).ready(function() {
    $(".aboutactive").click( function() {
        $(".window").addClass("hidden");
        $("#personalinfo").removeClass("hidden");
        setActiveTaskbar("#aboutmetaskbar");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#aboutme p").css("border-color", "white");
    });

    $(".resumeactive").click( function() {
        $(".window").addClass("hidden");
        $("#resumeexplorer").removeClass("hidden");
        setActiveTaskbar("#resumetaskbar");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#resume p").css("border-color", "white");
    });

    $(".projectsactive").click( function() {
        $(".window").addClass("hidden");
        $("#projectswindow").removeClass("hidden");
        setActiveTaskbar("#projectstaskbar");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#projectfolder p").css("border-color", "white");
    });

    $("#github").click( function() {
        window.open("https://github.com/DConquit");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#github p").css("border-color", "white");
    });

    $("#email").click( function() {
        window.location.href = "mailto:dconquit@gmail.com";
        $(".deskobject p").css("border-color", "#7a3045");
        $("#email p").css("border-color", "white");
    });

    $(".settingsactive").click( function() {
        $(".window").addClass("hidden");
        $("#settingswindow").removeClass("hidden");
        setActiveTaskbar("#settingstaskbar");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#settings p").css("border-color", "white");
    });

    $(".meteoractive").click( function() {
        $(".window").addClass("hidden");
        $("#meteoroidswindow").removeClass("hidden");
        setActiveTaskbar("#meteoroidstaskbar");
        $(".deskobject p").css("border-color", "#7a3045");
        $("#meteoroids p").css("border-color", "white");
    });

    $("#meteorsource").click( function() {
        window.open("https://github.com/DConquit/Meteoroids");
        $(".deskobject p").css("border-color", "#7a3045");
        $(".folderobject p").css("border-color", "white");
        $("#meteorsource p").css("border-color", "#2e222f");
    })

});

// Resets the colours of all taskbar buttons
function resetTaskbar() {
    $(".taskbarbutton").css({"border-right-color": "#625565", "border-bottom-color": "#625565",
        "border-left-color": "white", "border-top-color": "white", "background-color": "#cbc6c1"});
}

// Sets the colours of the active taskbar button
function setActiveTaskbar(taskID) {
    resetTaskbar();
    $(taskID).removeClass("hidden");
    $(taskID).css({"border-right-color": "white", "border-bottom-color": "white",
        "border-left-color": "#625565", "border-top-color": "#625565", "background-color": "#d9d7d5"});
}