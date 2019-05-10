# frozen_string_literal: true

class GroupEvent < ApplicationRecord
  belongs_to :user

  default_scope -> { where(deleted_at: nil) }

  with_options if: :published? do |group_event|
    group_event.validates :status,
                          :title,
                          :description,
                          :name,
                          :location,
                          :starts_at,
                          :ends_at,
                          presence: true
  end

  enum status: %i[published unpublished]

  def soft_destroy!
    update_attribute :deleted_at, Date.current
  end

  def days
    return 0 unless starts_at && ends_at

    (ends_at - starts_at).to_i
  end

  def days=(days)
    self.starts_at = starts_at ? self.starts_at : Date.current
    self.ends_at = starts_at + days.days
  end
end
