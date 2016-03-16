$(document).ready(function(){
  $('#studiocal').fullCalendar({
    header: {
      left: '',
      center: 'title',
      right: ''
    },
    editable: false,
    allDaySlot: false,
    defaultView: 'month',
    height: 300,
    aspectRatio: 2,
    slotMinutes: 60,
    loading: function(bool){
      if (bool)
        $('#loading').show();
      else
        $('#loading').hide();
    },
    events: "/availabilities/get_slots",
    timeFormat: 'hh tt{ - hh tt}'
  });
});



