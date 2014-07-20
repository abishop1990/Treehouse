class TodoItem < ActiveRecord::Base
    belongs_to :todo_list

    validates :content, presence: true, length: {minimum: 2}


    scope :complete, -> { where("completed_at IS NOT NULL") }
    scope :incompleted, -> { where(completed_at: nil) }


    #I don't think this is the best way to do this
    #But I'm following along a tutorial and I don't want to break anything so...
    def completed?
        !completed_at.blank?
    end

end
