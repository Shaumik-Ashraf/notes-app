namespace :notes do
  desc "Delete notes older than #{Rails.application.config.x.purge_notes_after.parts}"
  task purge: :environment do
    Note.where([ "created_at < ?", Rails.application.config.x.purge_notes_after.ago ]).destroy_all
  end
end
