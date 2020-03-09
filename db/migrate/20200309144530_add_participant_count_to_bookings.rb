class AddParticipantCountToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :participant_count, :integer
  end
end
