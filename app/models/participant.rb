# frozen_string_literal: true

class Participant < ApplicationRecord
  belongs_to :booking
  belongs_to :invitee, class_name: 'User', foreign_key: 'invitee_id'

  # Write your code here
end
