$(document).ready(function () {
    var task_id = $('#task_id').text();
    $.ajax({
        type: "POST",
        url: "/tasks/" + task_id + "/read",
        data: {
            "id" : task_id
        }
    })
});