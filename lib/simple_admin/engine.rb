require 'kaminari'
require 'simple_form'

module SimpleAdmin
  class Engine < ::Rails::Engine
    isolate_namespace SimpleAdmin
  end

  class << self
    mattr_accessor :config_username
    mattr_accessor :config_password
    mattr_accessor :config_site_name
    mattr_accessor :config_model_blacklist
    mattr_accessor :config_visible_columns_blacklist
    mattr_accessor :config_editable_columns_blacklist
    mattr_accessor :config_creatable_models_whitelist
    mattr_accessor :config_editable_associations_whitelist
    mattr_accessor :config_extensions

    # default values for config params
    self.config_username = "admin"
    self.config_password = "password"
    self.config_site_name = "Administration"
    self.config_model_blacklist = []
    self.config_visible_columns_blacklist = []
    self.config_editable_columns_blacklist = []
    self.config_creatable_models_whitelist = []
    self.config_editable_associations_whitelist = {
      # Example: "Question" => [:groups]
    }
    self.config_extensions = [
      # Example: "UploadDummyData"
    ]
  end

  # this function maps the vars from your app into your engine
  def self.setup(&block)
    yield self
  end
end
