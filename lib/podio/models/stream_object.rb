class Podio::StreamObject < ActivePodio::Base
  property :id, :integer
  property :type, :string
  property :last_update_on, :datetime
  property :title, :string
  property :link, :string
  property :rights, :array
  property :data, :hash
  property :comments_allowed, :boolean
  property :user_ratings, :hash
  property :created_on, :datetime

  has_one :created_by, :class => 'ByLine'
  has_one :created_via, :class => 'Via'
  has_one :app, :class => 'Application'
  has_one :space, :class => 'Space'
  has_one :org, :class => 'Organization'
  
  has_many :comments, :class => 'Comment'
  has_many :files, :class => 'FileAttachment'
  has_many :activity, :class => 'Activity'

  alias_method :activities, :activity

  class << self
    def find_all(options={})
      list Podio.connection.get { |req|
        req.url("/stream/v2/", options)
      }.body      
    end

    def find_all_by_space_id(space_id, options={})
      list Podio.connection.get { |req|
        req.url("/stream/space/#{space_id}/v2/", options)
      }.body      
    end

    def find_all_by_org_id(org_id, options={})
      list Podio.connection.get { |req|
        req.url("/stream/org/#{org_id}/v2/", options)
      }.body      
    end

    def find_all_by_app_id(app_id, options={})
      list Podio.connection.get { |req|
        req.url("/stream/app/#{app_id}/", options)
      }.body      
    end

    def find_all_by_user_id(user_id, options={})
      list Podio.connection.get { |req|
        req.url("/stream/user/#{user_id}/", options)
      }.body      
    end
    
    def find_by_ref(ref_type, ref_id)
      member Podio.connection.get("/stream/#{ref_type}/#{ref_id}/v2").body
    end
    
    def find_all_personal(options={})
      list Podio.connection.get { |req|
        req.url("/stream/personal/", options)
      }.body      
    end    
  end
end
