module TasksHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_order}" : nil
    order = (column == sort_column && sort_order == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :order => order}, {:class => css_class}
  end

  def label_for_status(status)
    case status
    when 'yet_start'
      'label label-warning'
    when 'doing'
      'label label-info'
    when 'completed'
      'label label-success'
    else
    end
  end

  def complete_button_for_show(task_id)
    case Task.find(task_id).status
    when 'yet_start', 'doing'
      p = button_tag '完了' , class: 'btn btn-info btn-large complete_button', onclick: "turn_status_to_complete(this, #{task_id});"
    when 'completed' then
    end
  end
end

