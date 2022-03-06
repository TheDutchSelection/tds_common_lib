$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'tds_common_lib/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'tds_common_lib'
  spec.version     = TdsCommonLib::VERSION
  spec.authors     = ['GM']
  spec.summary     = 'Commonly used stuff by TDS'
  spec.description = 'Commonly used stuff by TDS'

  spec.files = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
  spec.test_files = Dir['spec/**/*']

  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'figaro'
  spec.add_development_dependency 'pg'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'timecop'

  spec.add_runtime_dependency 'autoprefixer-rails', '>= 10.3.3.0'
  spec.add_runtime_dependency 'bootstrap_form', '>= 5.0.0'
  spec.add_runtime_dependency 'bootstrap4-kaminari-views', '>= 1.0.1'
  spec.add_runtime_dependency 'breadcrumbs_on_rails', '>= 4.1.0'
  spec.add_runtime_dependency 'carrierwave', '>= 2.2.2'
  spec.add_runtime_dependency 'iban-tools', '1.1.0'
  spec.add_runtime_dependency 'rails', '>= 6.1.4.1'
  spec.add_runtime_dependency 'stimulus-rails', '>= 1.0.4'
  spec.add_runtime_dependency 'turbo-rails', '>= 1.0.1'
end
