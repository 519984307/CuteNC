//todo przerobic xmlhttprequest na jquery post
//Homing

async function refresh() {
    $.ajax({
        type: "GET",
        url: "/",
        data: { home: axis },
        dataType: "json"
    });
}

function HomeAxes(axis) {
    $.ajax({
        type: "POST",
        url: "/",
        data: { home: axis },
        dataType: "json"
    });
}

//Setting zero

async function SetZero(axis) {
    // X, Y, Z or ALL
    $.ajax({
        type: "POST",
        url: "/",
        data: { setZero: axis },
        dataType: "json"
    });
}

//Jogging axes

async function MoveAxis(axis) {
    //get feedrate
    // X, Y, Z or ALL
    $.ajax({
        type: "POST",
        url: "/",
        data: { moveAxis: axis, feedrate: currentFeedrate, resolution: currentResolution },
        dataType: "json"
    });
}
//Set json file settings

function SetJsonFile(data) {
    $("#inputFeedrate").val(data.feedRate);
    currentFeedrate = data.feedRate;

    $("#inputRefreshRate").val(data.refreshRate);
    if (data.refreshRate <= 100) {
        $('#RefreshRateWarning').show();
    } else {
        $('#RefreshRateWarning').hide();
    }

    data.axes.forEach(function(doc) {
        {
            if (doc.axis == "X") {
                doc.visible ? $('.XAxis').show() & $('#XAxisVisible').prop('checked', true) : $('.XAxis').hide() & $('#XAxisVisible').prop('checked', false)
            }
            if (doc.axis == "Y") {
                doc.visible ? $('.YAxis').show() & $('#YAxisVisible').prop('checked', true) : $('.YAxis').hide() & $('#YAxisVisible').prop('checked', false)
            }
            if (doc.axis == "Z") {
                doc.visible ? $('.ZAxis').show() & $('#ZAxisVisible').prop('checked', true) : $('.ZAxis').hide() & $('#ZAxisVisible').prop('checked', false)
            }
            if (doc.axis == "A") {
                doc.visible ? $('.AAxis').show() & $('#AAxisVisible').prop('checked', true) : $('.AAxis').hide() & $('#AAxisVisible').prop('checked', false)
            }

        }
    })
}

//Save to json file
function SaveSettings() {
    var X = document.getElementById('XAxisVisible').checked;
    var Y = document.getElementById('YAxisVisible').checked;
    var Z = document.getElementById('ZAxisVisible').checked;

    var params = "";
}

function returnData() {
    $.ajax({
        type: "GET",
        url: "/getData",
        dataType: "json",
        success: function(data) {
            console.log('success');
            console.log(data);
            $("#XaxisValue").val(data.x);
            $("#YaxisValue").val(data.y);
            $("#ZaxisValue").val(data.z);
        },
        error: function(data) {
            console.log('error');
            var jsondata = JSON.parse(data.responseText)
            console.log(jsondata);
            console.log(data);
        },
        done: function(data) {
            console.log(data);
        }
    });

}
//Setting feedrate
var currentFeedrate;
var currentResolution = 1;
$(document).ready(function() {



    // if (typeof(EventSource) !== "undefined") {
    //     var source = new EventSource("http://localhost:8080/data");
    //     source.onmessage = function(event) {
    //         var jsondata = JSON.parse(event.data)
    //         console.log(jsondata);
    //     };
    // } else {
    //     console.log("Sorry, your browser does not support server-sent events...");
    // }

    $.getJSON("./assets/WebWidgetSettings.json", function(data) {
        SetJsonFile(data);
    }).done(function(data) {
        setInterval(() => {
            console.log("refreshing");
            returnData();
        }, $('#inputRefreshRate').val());
    });
    // //

    //not yet implemented
    $('#BAxisSwitch').hide();
    $('#CAxisSwitch').hide();


    //Move resolution change
    $('input[type=radio][name=resolution]').on('change', function() {
        currentResolution = $(this).val();
    });

    //Input feedrate change
    $('#inputFeedrate').on('change', function() {
        currentFeedrate = $(this).val();
    });

    //Input refreshrate change
    $('#inputRefreshRate').on('change', function() {
        if ($('#inputRefreshRate').val() <= 100) {
            $('#RefreshRateWarning').show();
        } else {
            $('#RefreshRateWarning').hide();
        }
    });

    $("#myTab a").click(function(e) {
        e.preventDefault();
        $(this).tab("show");
    });

    $('body').css('visibility', 'visible');

});