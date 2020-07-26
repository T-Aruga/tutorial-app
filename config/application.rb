require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.generators do |g|
          g.test_framework :rspec,
            fixtures: true,         # モデル作成時にフィクスチャの作成を有効化(後述のfactory_girlが適用される)
            view_specs: false,      # 以下、必要に応じて任意にトグルする
            helper_specs: false,
            routing_specs: false,
            controller_specs: false,
            request_specs: true
          # fixtureの代わりにfactory_girlを使うよう設定
          g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Don't generate system test files.
    config.generators.system_tests = nil
    # 認証トークンをremoteフォームに埋め込む
    config.action_view.embed_authenticity_token_in_remote_forms = true
  end
end
