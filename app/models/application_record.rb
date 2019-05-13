class ApplicationRecord < ActiveRecord::Base
  PICTO_PRATCIEN_URL = "https://www.zenest.pro/assets/home_picto/praticiens-62f48673f60ca36ef9fa598367d125ca9e31f42dfa79249774c40b73dcf23e3f.png"
  #ActionController::Base.helpers.image_url("home_picto/praticiens.png"),
  self.abstract_class = true
end
