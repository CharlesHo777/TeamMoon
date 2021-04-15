ActiveAdmin.register_page "Dashboard", namespace: :coord do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  action_item :view_my_account_info do
    link_to("View My Account Info", "/coord/coord_users/#{current_coord_user.id}")
  end

  action_item :edit_my_account do
    link_to("Change Email Or Password", edit_coord_user_registration_path)
  end

  action_item :questionnaires do
    link_to("Questionnaires", '/rapidfire')
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end

end
