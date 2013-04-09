require 'mingle4r'

class Mingle

  class << self

    def create(*args)
      card = new *args
      card.save
      card
    end

    def client
      @@client ||= Mingle4r::MingleClient.new(
        Setting[:mingle][:url],
        Setting[:mingle][:username],
        Setting[:mingle][:password],
        projects.first
      )
    end

    # generates a url for a mingle card
    def url(card)
      project = card.class.site.path.split('/').last
      "#{Mingle.base_url}/projects/#{project}/cards/#{card.number}"
    end

    def base_url
      Setting[:mingle][:url]
    end

    def projects
      if mingle = Setting.mingle
        if projects = mingle[:projects]
          return @@projects ||= projects.split(/\s*,\s*/)
        end
      end
      []
    end

    def project_options
      @@project_options ||= Mingle4r::API::Project.find(:all).map do |project|
        [project.name, project.identifier] if projects.include?(project.identifier)
      end.compact
    end

    def reset
      @@client          = nil
      @@projects        = nil
      @@project_options = nil
    end

    def default_attributes
      {'card_type_name' => Setting[:mingle][:card_type], 'name' => nil, 'properties' => []}
    end

    def project_all(params = {})
      conds = params[:conditions] || []

      mql = "SELECT '#{fields.join("', '")}' WHERE Type = '#{Setting[:mingle][:card_type]}' AND #{conds.join(' AND ')}"
      Rails.logger.debug("FfcrmMingle is sending mql for project [#{client.proj_id}]: #{mql}")
      client.execute_mql(mql).map { |card| new(card) }
    end

    def all(*args)
      x = projects.map do |proj_id|
        client.proj_id = proj_id
        project_all *args
      end.flatten
    end

    def new(*args)
      params = args.slice!(0) || {}
      if project = params.delete(:project)
        client.proj_id = project
      end

      card = client.new_card
      card.attributes = default_attributes.merge(params)

      card
    end

    def fields
      if mingle = Setting.mingle
        if fields = mingle[:fields]
          return fields.split(/\s*,\s*/)
        end
      end
      []
    end

  end
end
