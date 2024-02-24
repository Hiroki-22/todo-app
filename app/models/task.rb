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
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tasks_on_user_id  (user_id)
#
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
end
