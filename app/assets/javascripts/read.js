javascript:
        $(document).ready(function () {
        var user_id = #{@task.id};
        $.ajax({
            url: '#{read_task_path}',
            type: 'POST',
            data: {
                read_id: user_id
            },
            timeout: 10000
            // 送信前
            // beforeSend: function (xhr, settings) {
            // },
            // // 応答後
            // complete: function (xhr, textStatus) {
            // },
            //
            // // 通信成功時の処理
            // success: function (result, textStatus, xhr) {
            // },
            // // 通信失敗時の処理
            // error: function (xhr, textStatus, error) {
            // }
        });
    });