class Mingle

  def self.projects
    @@projects ||= Setting[:mingle][:projects].split(/[,\s]+/)
  end

  def self.client
    @@client ||= MingleClient.new(
      Setting[:mingle][:url],
      Setting[:mingle][:username],
      Setting[:mingle][:password],
      projects.first
    )
  end

  def self.reset
    @@projects = nil
    @@client   = nil
  end

  def self.default_attributes
    {'card_type_name' => Setting[:mingle][:card_type], 'name' => nil, 'properties' => []}
  end

  def self.new(*args)
    params = args.slice!(0) || {}
    if project = params.delete(:project)
      client.proj_id = project
    end

    card = client.new_card
    card.attributes = default_attributes.merge(params)
    card
  end

  def self.create(*args)
    card = new *args
    if card.save
      project_all(:conditions => ["number = #{card.number}"]).first
    else
      card
    end
  end

  def self.fields
    Setting[:mingle][:fields].split(/\s*,\s*/)
  end

  def self.project_all(params = {})
    conditions = params[:conditions] || []
    conditions << ["Type = '#{Setting[:mingle][:card_type]}'"]

    client.execute_mql(
      "SELECT '#{fields.join("', '")}' WHERE #{conditions.join(' AND ')}"
    ).map { |card| new(card) }
  end

  def self.all(*args)
    projects.map do |proj_id|
      client.proj_id = proj_id
      project_all *args
    end.flatten
  end
end
