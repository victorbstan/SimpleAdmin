ActionController::Parameters.permit_all_parameters = true

class SimpleAdmin::AdminController < ApplicationController
  http_basic_authenticate_with name: SimpleAdmin.config_username, password: SimpleAdmin.config_password

  before_action :admin
  before_action :setup
  before_action :restrict

  layout "simple_admin/application"

  def index
  end

  def model_index
    @resources = @model_name.constantize.order('updated_at DESC').page(params[:page]) || []
    render :index
  end

  def model_edit
    @resource = @admin.get_resource(params[:model_name], params[:id])
  end

  def model_new
    @resource = @admin.new_resource(params[:model_name])
  end

  def update
    form_params = params[@model_name.downcase]
    @resource = @admin.get_resource(@model_name, params[:id])
    @resource.assign_attributes form_params.to_h.symbolize_keys!

    if @resource.save
      redirect_to admin_model_index_path @model_name
    else
      flash[:error] = "Could not update #{@model_name}! – #{@resource.errors.messages.to_a.join(", ")}"
      redirect_to admin_model_edit_path(@model_name, params[:id])
    end
  end

  def create
    form_params = params[@model_name.downcase]
    @resource = @admin.new_resource(@model_name)
    @resource.assign_attributes form_params.to_h.symbolize_keys!

    if @resource.save
      redirect_to admin_model_index_path @model_name
    else
      flash[:error] = "Could not create #{@model_name}! – #{@resource.errors.messages.to_a.join(", ")}"
      redirect_to admin_model_new_path @model_name
    end
  end

  def destroy
    @resource = @admin.get_resource(@model_name, params[:id])
    @resource.destroy!
    redirect_to admin_model_index_path @model_name
  end

  def extension
    @extension = @admin.extensions.find{ |e| e.constant.name == params[:name].camelize }
    @extension_instance = @extension.instantiate
    render path_to_extension_view
  end

  def extension_post
    @extension = @admin.extensions.find{ |e| e.constant.name == params[:name].camelize }
    @extension_instance = @extension.instantiate

    if params[:extension].present?
      @extension_instance.form_params = params[:extension]

      if @extension_instance.process!
        # success
        flash[:notice] = @extension_instance.flash_notice
        redirect_to admin_extension_path(params[:name])
      else
        # failure
        flash[:alert] = @extension_instance.flash_alert
        render path_to_extension_view
      end
    end
  end

  private

  def admin
    @admin = Admin.new admin_config
  end

  def setup
    @table_models = @admin.table_models
    @creatable_resources = @admin.creatable_models_whitelist
  end

  def restrict
    # make sure we only try to access what we can
    return unless params[:model_name]
    @model_name = params[:model_name]
    render(text: "Could not access that Model", status: 401) unless @table_models.map(&:name).include?(@model_name)
  end

  def admin_config
    {
      model_blacklist:                  SimpleAdmin.config_model_blacklist,
      visible_columns_blacklist:        SimpleAdmin.config_visible_columns_blacklist,
      editable_columns_blacklist:       SimpleAdmin.config_editable_columns_blacklist,
      creatable_models_whitelist:       SimpleAdmin.config_creatable_models_whitelist,
      editable_associations_whitelist:  SimpleAdmin.config_editable_associations_whitelist,
      extensions:                       SimpleAdmin.config_extensions
    }
  end

  def path_to_extension_view
    # TODO: make hardcoded path to view configurable
    "/simple_admin/extensions/#{params[:name]}"
  end
end
