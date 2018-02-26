task spec: ["postgres:db:test:prepare"]

namespace :postgres do
  namespace :db do |ns|
    task :drop do
      Rake::Task["db:drop"].invoke
    end

    task :create do
      Rake::Task["db:create"].invoke
    end

    task :setup do
      Rake::Task["db:setup"].invoke
    end

    task :migrate do
      Rake::Task["db:migrate"].invoke
    end

    task :rollback do
      Rake::Task["db:rollback"].invoke
    end

    task :seed do
      Rake::Task["db:seed"].invoke
    end

    task :version do
      Rake::Task["db:version"].invoke
    end

    namespace :schema do
      task :load do
        Rake::Task["db:schema:load"].invoke
      end

      task :dump do
        Rake::Task["db:schema:dump"].invoke
      end
    end

    namespace :test do
      task :prepare do
        Rake::Task["db:test:prepare"].invoke
      end
    end

    ns.tasks.each do |task|
      task.enhance ["postgres:set_custom_config"] do
        Rake::Task["postgres:revert_to_original_config"].invoke
      end
    end
  end

  task :set_custom_config do
    @original_config = {
      env_schema: ENV['SCHEMA'],
      config: Rails.application.config.dup
    }

    ENV['SCHEMA'] = "db_postgres/schema.rb"
    Rails.application.config.paths['db'] = ["db_postgres"]
    Rails.application.config.paths['db/migrate'] = ["db_postgres/migrate"]
    Rails.application.config.paths['db/seeds.rb'] = ["db_postgres/seeds.rb"]
    Rails.application.config.paths['config/database'] = ["config/database_postgres.yml"]
  end

  task :revert_to_original_config do
    ENV['SCHEMA'] = @original_config[:env_schema]
    Rails.application.config = @original_config[:config]
  end
end
