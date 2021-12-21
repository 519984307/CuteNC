//todo przerobic xmlhttprequest na jquery post
//Homing

function HomeAxes(axis) {
    $.ajax({
        type: "POST",
        url: "/",
        data: { home: axis },
        dataType: "json",
        success: function () {
            console.log('success');
        },
        error: function () {
            console.log('error');
        }
    });
}

//Setting zero

function SetZero(axis) {
    // X, Y, Z or ALL
    $.ajax({
        type: "POST",
        url: "/",
        data: { setZero: axis },
        dataType: "json",
        success: function () {
            console.log('success');
        },
        error: function () {
            console.log('error');
        }
    });
}

//Jogging axes

function MoveAxis(axis) {

    //get feedrate
    // X, Y, Z or ALL
    $.ajax({
        type: "POST",
        url: "/",
        data: { moveAxis: axis },
        dataType: "json",
        success: function () {
            console.log('success');
        },
        error: function () {
            console.log('error');
        }
    });
}
//Set json file settings

function SetJsonFile(data) {
    $("#inputFeedrate").val(data.feedRate);
    $("#inputRefreshRate").val(data.refreshRate);
    if (data.refreshRate <= 100) {
        $('#RefreshRateWarning').show();
    } else {
        $('#RefreshRateWarning').hide();
    }

    data.axes.forEach(function (doc) {
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
        success: function () {
            console.log('success');
        },
        error: function () {
            console.log('error');
        }
    });
}

//Setting feedrate
$(document).ready(function () {

    $.getJSON("./assets/WebWidgetSettings.json", function (data) {
        console.log(data);
    }).done(function (data) {
        SetJsonFile(data);
    }).fail(function () {
        console.log("error");
    }).always(function () {
        console.log("complete");
    });

    //not yet implemented
    $('#BAxisSwitch').hide();
    $('#CAxisSwitch').hide();


    //Move resolution change
    $('input[type=radio][name=resolution]').on('change', function () {
        $.ajax({
            type: "POST",
            url: "/",
            data: { setResolution: $(this).val() },
            dataType: "json",
            success: function () {
                console.log('success');
            },
            error: function () {
                console.log('error');
            }
        });
    });

    //Input feedrate change
    $('#inputFeedrate').on('change', function () {
        console.log('this actually works');
    });

    //Input refreshrate change
    $('#inputRefreshRate').on('change', function () {
        if ($('#inputRefreshRate').val() <= 100) {
            $('#RefreshRateWarning').show();
        } else {
            $('#RefreshRateWarning').hide();
        }
    });

    $("#myTab a").click(function (e) {
        e.preventDefault();
        $(this).tab("show");
    });

    $('body').css('visibility', 'visible');
});

