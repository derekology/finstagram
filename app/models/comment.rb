class Comment < ActiveRecord::Base

    # define associations
    belongs_to :user
    belongs_to :finstagram_post

    # validation code
    validates_presence_of :text, :user, :finstagram_post

end