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
    page = 1

    request = Net::HTTP::Get.new("#{@mingle[:url]}.xml?page=#{page}&filters[]=[Type][is][#{@mingle[:card_type]}]")
    request.basic_auth(@mingle[:username], @mingle[:password])

    response = connection.request(request)
    if response.code == '200'
      results = Nokogiri::XML.parse(response.body)

      results.xpath('//card').each do |card|
        fields = @mingle[:fields].split(/,\s*/).map do |field|
          value = card.xpath(field)[0]
          value.content if value
        end.compact
        flash[:notice] = "#{fields.shift}: #{fields.join(', ')}"
      end
    else
      flash[:notice] = "#{response.code}: #{response.body}"
    end
  end

  def api_put
    number = 1
    description = 'Test'

    request = Net::HTTP::Put.new("#{@mingle[:url]}/#{number}.xml")
    request.basic_auth(@mingle[:username], @mingle[:password])
    request.set_form_data({"card[description]" => description})

    response = connection.request(request)
    if response.code == '200'
      print " ##{number}"
    else
      puts response.code
      puts response.body
    end
  end
end
