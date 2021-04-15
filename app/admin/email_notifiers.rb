# ActiveAdmin.register EmailNotifier do
#
#   # See permitted parameters documentation:
#   # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#   #
#   # Uncomment all parameters which should be permitted for assignment
#   #
#   permit_params :template, :user_id
#   #
#   # or
#   #
#   # permit_params do
#   #   permitted = [:template, :user_id]
#   #   permitted << :other if params[:action] == 'create' && current_user.admin?
#   #   permitted
#   # end
#   form do |f|
#     f.inputs do
#       f.input :template
#         f.select :participant_id, Participant.all.collect { |p| [p.email, p.id] }
#       end
#     f.actions
#   end
#   collection_action :resend_email, method: :get do
#     if params[:notifier]
#       notifier = EmailNotifier.find(params[:notifier])
#         NotificationMailer.notify_user(notifier.participant, notifier.template).deliver_later
#       flash[:notice] = "Email Successfully Sent to User"
#       redirect_to '/admin/email_notifiers'
#     end
#   end
#   controller do
#     def create
#       unless params[:email_notifier][:template].blank?
#           @notification = EmailNotifier.new(template: params[:email_notifier][:template], participant_id: params[:email_notifier][:participant_id])
#         if @notification.save(validate: false)
#           NotificationMailer.notify_user(Participant.find(params[:email_notifier][:participant_id]),  params[:email_notifier][:template] ).deliver_later
#           flash[:notice] = 'Email Notifier Created and Email Sent Successfully!'
#           redirect_to '/admin/email_notifiers'
#         else
#           flash[:error] = @notification.errors.messages
#           redirect_to '/admin/email_notifiers'
#         end
#       end
#     end
#   end
#   index do
#     selectable_column
#     id_column
#     column :template
#     column :user
#     column "Email" do |obj|
#       link_to('Resend Email', resend_email_admin_email_notifiers_path(notifier: obj), format: :html	)
#     end
#     actions
#   end
#
# end
