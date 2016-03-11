
  $(document).ready(function(){
      // page is now ready, initialize the calendar...
      $('#new_event').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        $.ajax({
          url: url,
          beforeSend: function() {
            $('#loading').show();
          },
          complete: function() {
            $('#loading').hide();
          },
          success: function(data) {
            $('#create_event').replaceWith(data['form']);
            $('#create_event_dialog').dialog({
              title: 'New Event',
              modal: true,
              width: 500,
              close: function(event, ui) { $('#create_event_dialog').dialog('destroy') }
            });
          }
        });
      });

      $('#calendar').fullCalendar({
          editable: true,
          selectable: true,
          select: function(){
            alert("yolo");
          },
          header: {
              left: 'prev,next today',
              center: 'title',
              right: 'month,agendaWeek,agendaDay'
          },
          defaultView: 'agendaWeek',
          height: 500,
          slotMinutes: 60,
          loading: function(bool){
              if (bool)
                  $('#loading').show();
              else
                  $('#loading').hide();
          },
          events: "/availabilities/get",
          timeFormat: 'hh:mm t{ - hh:mm t} ',
          dragOpacity: "0.5",
          eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){
//              if (confirm("Are you sure about this change?")) {
                  moveEvent(event, dayDelta, minuteDelta, allDay);
//              }
//              else {
//                  revertFunc();
//              }
          },

          eventResize: function(event, dayDelta, minuteDelta, revertFunc){
//              if (confirm("Are you sure about this change?")) {
                  resizeEvent(event, dayDelta, minuteDelta);
//              }
//              else {
//                  revertFunc();
//              }
          },

          eventClick: function(event, jsEvent, view){
              showEventDetails(event);
          },




      });
  });
