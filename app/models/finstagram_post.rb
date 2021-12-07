class FinstagramPost < ActiveRecord::Base

    belongs_to :user
    has_many :comments
    has_many :likes

    validates :photo_url, :user, presence: true

    def humanized_time_ago
        time_ago_in_seconds = (Time.now - self.created_at).to_i

        s_in_m = 60
        m_in_h = 60
        h_in_d = 24

        time_ago_in_minutes = time_ago_in_seconds / s_in_m
        time_ago_in_hours = time_ago_in_minutes / m_in_h
        time_ago_in_days = time_ago_in_hours / h_in_d

        if time_ago_in_hours >= 25
            "#{time_ago_in_hours / 24} days ago" 

        elsif time_ago_in_hours >= 24
            "A day ago" 

        elsif time_ago_in_hours >= 2
          "#{time_ago_in_minutes / 60} hours ago"   

        elsif time_ago_in_hours >= 1
            "About an hour ago" 

        elsif time_ago_in_minutes >= 1
            "#{time_ago_in_minutes} minutes ago"

        elsif time_ago_in_seconds >= 5
            "#{time_ago_in_seconds} seconds ago"
            
        else
          "Just now"
        end
    end

    def likes_count
        self.likes.size
    end

    def comments_count
        self.comments.size
    end
end