class Admin::MingleController < Admin::ApplicationController
  before_filter :require_user
  before_filter "set_current_tab('admin/mingle')", :only => [ :index ]

  # GET /mingle
  #----------------------------------------------------------------------------
  def index
    @mingle = Setting[:mingle] ||= {}

    respond_to do |format|
      format.html # index.html.haml
    end
  end

  # PUT /mingle
  #----------------------------------------------------------------------------
  def update
    @mingle = params[:mingle]

    if params[:save]
      Setting[:mingle] = @mingle
      flash[:notice] = 'Mingle settings saved'

    elsif params[:test]
      api_get
    end

    respond_to do |format|
      format.js # update.js.rjs
    end
  end

protected

  def connection
    @connection ||= begin
      uri = URI.parse(@mingle[:url])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http
    end
  end

  def api_get
    mql = "SELECT #{@mingle[:fields]} WHERE 'Type' = '#{@mingle[:card_type]}'"

    request = Net::HTTP::Post.new("#{@mingle[:url]}/execute_mql.xml")
    request.basic_auth(@mingle[:username], @mingle[:password])
    request.set_form_data({"mql" => mql, "_method" => "get"})

    response = connection.request(request)
    if response.code == '200'
      results = Nokogiri::XML.parse(response.body)

      results.xpath('//result').each do |result|
        hash = {}
        result.element_children.map { |node| hash[node.name] = node.content }
        flash[:notice] = hash.map { |k,v| "#{k}: #{v}" }.join(', ')
      end
    else
      flash[:notice] = "#{response.code}: #{response.body}"
    end
  end

  def api_post
    description = 'Test'

    request = Net::HTTP::Post.new("#{@mingle[:url]}.xml")
    request.basic_auth(@mingle[:username], @mingle[:password])
    request.set_form_data({"card[name]" => description})

    response = connection.request(request)
    if response.code == '200'
      print " ##{number}"
    else
      puts response.code
      puts response.body
    end
  end
end
