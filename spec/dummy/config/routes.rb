Rails.application.routes.draw do
  mount TdsCommonLib::Engine => "/tds_common_lib"
end
