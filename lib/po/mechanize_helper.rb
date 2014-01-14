module Po
  module MechanizeHelper
    def agent(force_new=false)
      if force_new
        @_agent = Mechanize.new
      else
        @_agent ||= Mechanize.new
      end
      @_agent.keep_alive = false
      @_agent.open_timeout = 10
      @_agent.read_timeout = 120
      @_agent.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:19.0) Gecko/20100101 Firefox/19.0'
      @_agent.ssl_version = 'SSLv3'
      # @_agent.set_proxy("localhost", 8888)
      @_agent
    end

    def set_timeout(seconds)
      @_agent.open_timeout = seconds
    end

    def html_page body
      uri = URI 'http://example/'
      Mechanize::Page.new uri, nil, body, 200, agent
    end

    def post_multipart(url, post_params, headers={})
      post_params = post_params.with_indifferent_access
      page = self.html_page <<-BODY
      <form action="#{url}" enctype="multipart/form-data" method="POST">
      </form>
      BODY

      page.forms.first.tap do |form|
        post_params.each do |key, value|
          if value.is_a?(IO)
            ul = Mechanize::Form::FileUpload.new({'name' => key.to_s},::File.basename(value.path))
            ul.file_data = value.read
            form.file_uploads << ul
          else
            form.add_field! key.to_s, value
          end
        end
      end.submit nil, headers
    end
  end
end
