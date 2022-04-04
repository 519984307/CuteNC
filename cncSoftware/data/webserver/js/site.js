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
    var A = document.getElementById('AAxisVisible').checked;

    var params = "";

    $.ajax({
        type: "POST",
        url: "/",
        data: { jsonFile: params },
        dataType: "json",
        success: function() {
            console.log('success');
        },
        error: function() {
            console.log('error');
        }
    });
}

//Setting feedrate
var currentFeedrate;
var currentResolution = 1;
$(document).ready(function() {


    async function refresh() {

    }

    $.getJSON("./assets/WebWidgetSettings.json", function(data) {
        SetJsonFile(data);
    }).done(function(data) {
        setInterval(() => {
            console.log("refreshing");
            $.getJSON("./assets/WebWidgetPositions.json", function(data) {
                $('#XaxisValue').val(data.x);
                $('#YaxisValue').val(data.y);
                $('#ZaxisValue').val(data.z);
            })
        }, $('#inputRefreshRate').val());



    }).fail(function() {
        console.log("error");
    }).always(function() {
        console.log("complete");
    });
    //

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