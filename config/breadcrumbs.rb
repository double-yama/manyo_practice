crumb :root do
  link fa_icon('home') + " ホーム", root_path
end

crumb :my_page do
  link " マイページ", mypage_tasks_path
  parent :root
end

crumb :label do
  link "ラベル一覧", labels_path
  parent :root
end

crumb :users do
  link "ユーザ一覧", admin_users_path
  parent :root
end

crumb :show_task do |task|
  link "#{task.name}", task_path
  parent :my_page
end

crumb :group do
  link "グループ一覧" , groups_path
  parent :root
end

crumb :group_new do
  link "新規グループ作成" , new_group_path
  parent :group
end


# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).