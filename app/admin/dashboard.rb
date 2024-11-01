ActiveAdmin.register_page "Dashboard", namespace: :admin do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  action_item :view_my_account_info do
    link_to("View My Account Info", "/admin/admin_users/#{current_admin_user.id}")
  end

  action_item :edit_my_account do
    link_to("Change Email Or Password", edit_admin_user_registration_path)
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
