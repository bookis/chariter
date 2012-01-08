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
    postTask($(this))
  });
  
});

$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

function postTask(cell) {
  $.ajax({
    url: '/tasks',
    type: 'POST',
    dataType: 'json',
    data: {task: {due_date: cell.data('date'), commitment_id: cell.data('commitment')}},
    // data: {task: {due_date: cell, commitment_id: 2}},
    success: function(data, textStatus, xhr) {
      cell.text(data.task.commitment.name)
      cell.addClass('selected')
      cell.find('.add_task').val(true)
    },
    error: function(xhr, textStatus, errorThrown) {
      cell.removeClass('selected')
    }
  });
};