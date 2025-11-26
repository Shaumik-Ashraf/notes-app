require "test_helper"
require "rake"

# @note purge setting is set to 2.days in config/environments/test.rb
class NotesPurgeTaskTest < ActiveSupport::TestCase
  #   Rake.application.rake_require "greet"

  setup do
    # Make sure the task is loaded and reset its state so we can run it again
    Rake.application = Rake::Application.new
    Rake.application.load_rakefile

    # Stub the :environment task (Rails loads it automatically)
    Rake::Task.define_task(:environment)

    @task = Rake::Task["notes:purge"]
  end

  test "it deletes notes older than two days" do
    note = Note.create(body: "delete me")
    note.update(created_at: 10.days.ago)
    assert_difference("Note.count", -1) do
      @task.invoke
    end
  end

  test "it does not delete notes younger than two days" do
    note = Note.create(body: "delete me not")
    assert_no_difference("Note.count") do
      @task.invoke
    end
  end

  teardown do
    # Clean up after each test – reset the task so it can be invoked again.
    @task.reenable
  end
end
