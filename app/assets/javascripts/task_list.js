javascript:
    var b1 = $('#expired_task_list');
    var b2 = $('#more_btn_expired');

$(function () {
    // eachいるか？
    b1.each(function () {
        $(this).find("tr:gt(5)").each(function () {
            $(this).hide();
        });

        b2.find('.open_expired').nextAll().hide();
        b2.find('.open_expired').click(function () {
            b2.find('.open_expired').hide();
            b1.find("tr").show(400);
            b2.find('.open_expired').nextAll().show();
            return false;
        });

        // textだけ変えればいい
        // buttonを二つも並べなくていい

        b2.find('.close_expired').click(function () {
            b2.find('.open_expired').show();
            b2.find('.open_expired').nextAll().hide();
            b1.find("tr:gt(5)").each(function () {
                $(this).hide();
            });
            return false;
        });
    });
});

var b3 = $('#deadline_in_three_days_task_list');
var b4 = $('#more_btn_deadline_in_three_days');

$(function () {
    b3.each(function () {
        $(this).find("tr:gt(5)").each(function () {
            $(this).hide();
        });

        b4.find('.open_deadline_close').nextAll().hide();
        b4.find('.open_deadline_close').click(function () {
            b4.find('.open_deadline_close').hide();
            b3.find("tr").show(400);
            b4.find('.open_deadline_close').nextAll().show();
            return false;
        });

        b4.find('.close_deadline_close').click(function () {
            b4.find('.open_deadline_close').show();
            b4.find('.open_deadline_close').nextAll().hide();
            b3.find("tr:gt(5)").each(function () {
                $(this).hide();
            });
            return false;
        });
    });
});

$(function(){
    $(".tooltip a").hover(function() {
            $(this).next("span").stop().animate({opacity: "show", top: "40"}, 500);},
        function() {
            $(this).next("span").stop().animate({opacity: "hide", top: "35"}, 200);
        });
});