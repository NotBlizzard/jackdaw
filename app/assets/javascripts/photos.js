function gravatar(email,size) {
  var hash = md5(email.toLowerCase());
  return "http://www.gravatar.com/avatar/" + hash + "?s="+size;
}

$(document).ready(function() {
  $("#upload").click(function() {
    $("#upload_hidden").click();
    return false;
  });

  $(".rails-delete").on("ajax:success", function(e, data, status, xhr) {
    $(this).closest('.comment').remove();
  });

  $('#new_comment').on('ajax:success', function(e, data, status, xhr) {
    var data = JSON.parse(xhr.responseText);
    $("#comments").prepend("<div class='comment'><img class='comment-avatar' src='"+gravatar(data['email'], 40)+"'> " +
      "<a action='destroy' data-confirm='Are you sure?' class='fa fa-times rails-delete' data-remote='true' " +
      "rel='nofollow' data-method='post' href='/"+data['nick']+"/"+data['post_id']+"/comments/"+data['id']+"/delete'></a>" +
      "<span class='comment-nick'>"+data['nick']+"</span><br />" +
      "<span class='comment-date'>now</span><br />" +
      "<p class='comment-text'>"+data['content']+"</p></div>");
  });

  $('.image').draggable();
  $('.add_to').droppable({
    drop: function(event, ui) {
      var nick = $(ui.draggable).data('nick');
      var album_id = $(ui.draggable).data('album-id');
      var id = $(ui.draggable).data('id');
      $.ajax({
        url: '/' + nick + '/a/' + album_id,
        method: "PUT",
        data: {'photo_id': id},
        success: function() {
        }
      })
    }
  });
  $('.remove_from').droppable({
    drop: function(event, ui) {
       var nick = $(ui.draggable).data('nick');
      var album_id = $(ui.draggable).data('album-id');
      var id = $(ui.draggable).data('id');
      $.ajax({
        url: '/' + nick + '/a/' + album_id,
        method: 'PUT',
        data: {'photo_id': id, 'method': 'remove'},
        success: function() {

        }
      })
    }
  })
})