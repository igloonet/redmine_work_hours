# Hooks to attach to the Redmine Issues.
class WorkHoursIssueHook  < Redmine::Hook::ViewListener

  # Renders a select tag with all the Deliverables
  #
  # Context:
  # * :form => Edit form
  # * :project => Current project
  #
  def view_issues_form_details_top(context = { })
    if context[:project].module_enabled?('work_hours')
      setting = Setting.plugin_redmine_work_hours
      day = I18n.t('date.day_names', :locale => :en)[Time.now.wday].downcase
      work_hours_from = Time.parse("#{setting[(day+'_hours_from').to_sym]}:00")
      work_hours_to = Time.parse("#{setting[(day+'_hours_to').to_sym]}:00")
      text_to_display = Time.now > work_hours_from && Time.now < work_hours_to ? :text_during_work_hours : :text_not_during_work_hours

      text = textilizable(WorkHoursProjectSetting.first(:conditions => ['project_id = ?', context[:project].id]).send(text_to_display))
      return "<div class=\"wiki\">#{text}</div>"
    else
      return ''
    end
  end

  def view_issues_edit_notes_bottom(context = {})
    if context[:project].module_enabled?('work_hours')
      setting = Setting.plugin_redmine_work_hours
      day = I18n.t('date.day_names', :locale => :en)[Time.now.wday].downcase
      work_hours_from = Time.parse("#{setting[(day+'_hours_from').to_sym]}:00")
      work_hours_to = Time.parse("#{setting[(day+'_hours_to').to_sym]}:00")
      text_to_display = Time.now > work_hours_from && Time.now < work_hours_to ? :text_during_work_hours : :text_not_during_work_hours

      text = textilizable(WorkHoursProjectSetting.first(:conditions => ['project_id = ?', context[:project].id]).send(text_to_display))
      return "<div class=\"wiki\">#{text}</div>"
    else
      return ''
    end
  end
end