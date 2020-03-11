# frozen_string_literal: true

class Booking < ApplicationRecord
  has_many :participants, dependent: :destroy
  belongs_to :user
  belongs_to :room
  validates :start_time, :end_time, presence: true
  validate :time_validation?
  validate :Bookings_overlap?


  private

  def end_date_after_start_date
    return if start_time.blank? || end_time.blank?
  end

  def time_validation?
    if start_time >= end_time
      errors.add(:end_date, "end time should be after the start time")
    end
  end

  def Bookings_overlap?
    return if self
    .class
    .where.not(id: id)
    .where(room_id: room_id)
    .where(date: date)
    .where('start_time <= ? AND end_time >= ?', end_time, start_time)
    .none?

    errors.add(:base, 'The selected room is booked in the specified times')
  end
end
