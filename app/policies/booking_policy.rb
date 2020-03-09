class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
   true
  end

  def update?
    booking.user == user
  end

  def destroy?
    booking.user == user
  end

  def create?
    true
  end

  def show?
    true
  end

  def booking
    record
  end
end
