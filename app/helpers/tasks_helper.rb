module TasksHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_order}" : nil
    order = (column == sort_column && sort_order == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :order => order}, {:class => css_class}
  end
end

