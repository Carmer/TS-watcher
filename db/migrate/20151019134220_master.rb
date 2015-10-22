class Master < ActiveRecord::Migration
  def change

    create_table :sources do |t|
      t.string :identifier
      t.string :rootUrl
    end

    create_table :payloads do |t|
      t.string :url
      t.string :parameters
      t.string :responded_in
      t.string :requested_at
      t.string :user_agent
      t.string :source_id
      t.string :event_name
      t.string :referred_by
      t.string :requested_at
      t.string :resolution_width
      t.string :resolution_height
      t.string :request_type
      t.string :sha
      t.string :ip
    end
  end
end
