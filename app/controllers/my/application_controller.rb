class My::ApplicationController < ApplicationController
    layout 'my'
    before_filter :filter
    def filter
        $my_navs = YAML.load_file("config/datas/my.yml")
    end

end