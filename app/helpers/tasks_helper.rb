module TasksHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_order}" : nil
    order = (column == sort_column && sort_order == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :order => order}, {:class => css_class}
  end

  # def create_status_label(status)
  #   case status
  #   when 'yet_start'
  #     ''
  #   end
  #   t("column.status.#{task.status}")
  # end
end

