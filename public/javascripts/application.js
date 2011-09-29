$(document).ready(function() {
  $('#dates').datepicker()
  
  $('#zoomable #calendar .date').click(function() {
    $('.selected').removeClass('selected')
    $(this).addClass('selected')
  });
  
  
  setInterval(function() {
    $('#calendar .date').each(function(index) {
      $(this).css('height', $(this).width()*0.55)
    });
  },200 )
  
  $('#new_tasks #calendar .date').click(function() {
    $(this).toggleClass('selected')
    $(this).find('.add_task').val(true)
  });
  
  // Make form for tasks
  
});



function postTask(date) {
  task = {due_date: date}
  $.ajax({
    url: 'tasks',
    type: 'POST',
    dataType: 'json',
    data: {task: task},
    complete: function(xhr, textStatus) {
      console.log('comp')
    },
    success: function(data, textStatus, xhr) {
      console.log('succ')
    },
    error: function(xhr, textStatus, errorThrown) {
      console.log('fail')
    }
  });
};