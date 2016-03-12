// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require underscore
//= require gmaps/google
//= require moment
//= require_tree .

function moveEvent(event, dayDelta, minuteDelta, allDay){
    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta + '&all_day=' + allDay,
        dataType: 'script',
        type: 'post',
        url: "/availabilities/move"
    });
}

function resizeEvent(event, dayDelta, minuteDelta){
    jQuery.ajax({
        data: 'id=' + event.id + '&title=' + event.title + '&day_delta=' + dayDelta + '&minute_delta=' + minuteDelta,
        dataType: 'script',
        type: 'post',
        url: "/availabilities/resize"
    });
}

function showEventDetails(event){
    $('#event_desc').html(event.description);
    $('#edit_event').html("<a href = 'javascript:void(0);' onclick ='editEvent(" + event.id + ")'>Edit</a>");
    if (event.recurring) {
        title = event.title + "(Recurring)";
        $('#delete_event').html("&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete Only This Occurrence</a>");
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + true + ")'>Delete All In Series</a>")
        $('#delete_event').append("&nbsp;&nbsp; <a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", \"future\")'>Delete All Future Events</a>")
    }
    else {
        title = event.title;
        $('#delete_event').html("<a href = 'javascript:void(0);' onclick ='deleteEvent(" + event.id + ", " + false + ")'>Delete</a>");
    }
    $('#desc_dialog').dialog({
        title: title,
        modal: true,
        width: 500,
        close: function(event, ui){
            $('#desc_dialog').dialog('destroy')
        }

    });

}


function editEvent(event_id){
    jQuery.ajax({
      url: "/events/" + event_id + "/edit",
      success: function(data) {
        $('#event_desc').html(data['form']);
      }
    });
}

function deleteEvent(event_id, delete_all){
  var address = $('#studio_path').data('address');
  var url = address + "/" + event_id;
  jQuery.ajax({
    data: 'delete_all=' + delete_all,
    dataType: 'script',
    type: 'delete',
    url: url,
    success: refetch_events_and_close_dialog
  });
}

function refetch_events_and_close_dialog() {
  $('#calendar').fullCalendar( 'refetchEvents' );
  $('.dialog:visible').dialog('destroy');
}

function showPeriodAndFrequency(value){

    switch (value) {
        case 'Daily':
            $('#period').html('day');
            $('#frequency').show();
            break;
        case 'Weekly':
            $('#period').html('week');
            $('#frequency').show();
            break;
        case 'Monthly':
            $('#period').html('month');
            $('#frequency').show();
            break;
        case 'Yearly':
            $('#period').html('year');
            $('#frequency').show();
            break;

        default:
            $('#frequency').hide();
    }




}

// hi it's ray again. This seems to be the part that should actually generate the post request to create the events when the event form is submitted. I tried putting that alert for 'yolo' in there and couldn't get it to show up at all. I'm not sure it's going here just yet. If we could actually make it work, we may be able to not pass all the shitty data it's passing now. See below for how it's currently passing it. Ideally we could just pass in like start_time: 2016-3-12 5:00PM or something
/*
availability[start_time(1i)]:2016
availability[start_time(2i)]:3
availability[start_time(3i)]:12
availability[start_time(4i)]:13
availability[start_time(5i)]:32
availability[end_time(1i)]:2016
availability[end_time(2i)]:3
availability[end_time(3i)]:12
availability[end_time(4i)]:14
availability[end_time(5i)]:32*/

// $(document).ready(function(){
//   $('#create_event_dialog, #desc_dialog').on('submit', "#event_form", function(event) {
//     event.preventDefault();
//     alert('yolo');
//     $.ajax({
//       type: "POST",
//       data: $(this).serialize(),
//       url: $(this).attr('action'),
//       success: refetch_events_and_close_dialog,
//       error: handle_error
//     });

//     function handle_error(xhr) {
//       alert(xhr.responseText);
//     }
//   })
// });
