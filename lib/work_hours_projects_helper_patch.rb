module WorkHoursProjectsHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, ProjectsHelperMethodsWorkHours)

    base.class_eval do
      #unloadable

      alias_method_chain :project_settings_tabs, :work_hours
    end

  end
end

module ProjectsHelperMethodsWorkHours
  def project_settings_tabs_with_work_hours
    tabs = project_settings_tabs_without_work_hours
    action = {:name => 'work_hours', :controller => 'work_hours_settings', :action => :show, :partial => 'work_hours_settings/show', :label => :work_hours}

    tabs << action if User.current.allowed_to?(action, @project)

    tabs
  end
end

ProjectsHelper.send(:include, WorkHoursProjectsHelperPatch)
