$(document).on('turbolinks:load', function () {
    var tasks_count = $('.show_tasks_count');
    var tasks_detail = $('.show_tasks_detail');
    tasks_detail.hide();

    $('.week_for_task').click(function () {
        var tasks_detail = $(this).find('.show_tasks_detail');
        if ((tasks_detail).is(':hidden')) {
            $(this).find('.show_tasks_count').hide(400);
            $(this).find('.show_tasks_detail').show(400);
        } else {
            $(this).find('.show_tasks_detail').hide(400);
            $(this).find('.show_tasks_count').show(400);
        }
    });
});
