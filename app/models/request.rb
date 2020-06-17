# frozen_string_literal: true

class Request < ApplicationRecord
  validates_presence_of :title, :description, :reward
  belongs_to :requester, class_name: 'User'
  belongs_to :helper, required: false, class_name: 'User'
  has_many :offers
end
