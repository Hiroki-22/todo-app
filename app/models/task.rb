# == Schema Information
#
# Table name: tasks
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  time_limit :datetime
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#
class Task < ApplicationRecord
  has_one_attached :eyecatch

  validates :title, presence:true
  validates :title, length: { minimum: 2, maximum: 100}
  validates :title, format: { with: /\A(?!\@)/ }

  validates :content, presence:true
  validates :content, length: {minimum: 5, maximum: 100}
  validates :content, uniqueness: true

  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy

  def comment_count
    comments.count
  end

  def last_three_commenters
    comments.last(3).map(&:user).uniq.last(3)
  end
end
