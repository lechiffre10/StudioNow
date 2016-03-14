
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
        allDaySlot: false,
        editable: true,
        selectable: true,
        selectHelper: true,
        selectOverlap: false,
        select: function(start, end){

         var overlap = $('#calendar').fullCalendar('clientEvents', function(ev) {
          if(ev.id === undefined) {
            return false
          }
          var estart = new Date(ev.start);
          var eend = new Date(ev.end);

          return (
            ( Math.round(start) > Math.round(estart) && Math.round(start) < Math.round(eend) )
            ||
            ( Math.round(end) > Math.round(estart) && Math.round(end) < Math.round(eend) )
            ||
            ( Math.round(start) <= Math.round(estart) && Math.round(end) >= Math.round(eend) )
            );
        });
         if (overlap.length){
          return false;
        } else {
          var eventData;
          var eventData = {
            allDay: false,
            color: '#34AADC',
            title: 'Available',
            start: moment(start).format("YYYY-MM-DDTHH:mm:ss.SSS[Z]"),
            end: moment(end).format("YYYY-MM-DDTHH:mm:ss.SSS[Z]")
          }
          $('#calendar').fullCalendar('renderEvent',eventData);
          var address = $('#studio_path').data('address');
          $.ajax({
            url: address,
            method: 'POST',
            data: {availability: {start_time: moment(start).format("YYYY-MM-DDTHH:mm:ss.SSS[Z]"), end_time: moment(end).format("YYYY-MM-DDTHH:mm:ss.SSS[Z]")}},
            success: refetch_events_and_close_dialog
          });
        }
      },
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'agendaWeek,agendaDay'
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
      eventOverlap: function(stillEvent, movingEvent) {
        return false;
      },
      eventDrop: function(event, dayDelta, minuteDelta, allDay, revertFunc){

        var start = new Date(event.start);
        var end = new Date(event.end);

        var overlap = $('#calendar').fullCalendar('clientEvents', function(ev) {
          if( ev == event || ev.id == undefined) {
            return false;
          }
          var estart = new Date(ev.start);
          var eend = new Date(ev.end);

          return (
            ( Math.round(start) > Math.round(estart) && Math.round(start) < Math.round(eend) )
            ||
            ( Math.round(end) > Math.round(estart) && Math.round(end) < Math.round(eend) )
            ||
            ( Math.round(start) <= Math.round(estart) && Math.round(end) >= Math.round(eend) )
            );
        });
        if (overlap.length){
          revertFunc();
          return false;
        }else {moveEvent(event, dayDelta, minuteDelta, allDay);}

      },

      eventResize: function(event, dayDelta, minuteDelta, revertFunc){
        //              if (confirm("Are you sure about this change?")) {
         var start = new Date(event.start);
         var end = new Date(event.end);

         var overlap = $('#calendar').fullCalendar('clientEvents', function(ev) {
          if( ev == event || ev.id === undefined) {
            return false;
          }
          var estart = new Date(ev.start);
          var eend = new Date(ev.end);

          return (
            ( Math.round(start) > Math.round(estart) && Math.round(start) < Math.round(eend) )
            ||
            ( Math.round(end) > Math.round(estart) && Math.round(end) < Math.round(eend) )
            ||
            ( Math.round(start) <= Math.round(estart) && Math.round(end) >= Math.round(eend) )
            );
        });
         if (overlap.length){
          revertFunc();
          return false;
        }else {resizeEvent(event, dayDelta, minuteDelta);}
      },

      eventClick: function(event, jsEvent, view){
        showEventDetails(event);
      },




});
});
