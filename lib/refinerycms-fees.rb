require 'refinerycms-base'

module Refinery
  module Fees
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end
      
      config.to_prepare do
        User.module_eval do
          has_many :fees
        end
      end
      
      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = 'fees'
          plugin.activity = {
            :class => Fee,
            :title => 'from_account'
          }
        end
      end
    end
  end
end
