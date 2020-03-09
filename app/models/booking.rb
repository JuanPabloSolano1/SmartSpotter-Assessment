# frozen_string_literal: true

class Booking < ApplicationRecord
  has_many :participants
  belongs_to :user
  belongs_to :room
  validates :start_time, :end_time, presence: true
  validate :time_validation?

  private

  def end_date_after_start_date
    return if start_time.blank? || end_time.blank?
  end

  def time_validation?
    if start_time >= end_time
      errors.add(:end_date, "must be after the start time")
    end
  end

end
