module RtsApi
  class Film
    attr_reader :title, :title_short, :length, :rating, :website, :film_code,
                :mt_film_code, :shows

    include XmlReader
    
    def initialize(title:, title_short:, length:, rating:, website:,
                   film_code:, mt_film_code:, shows:)
      @title        = title
      @title_short  = title_short
      @length       = length
      @rating       = rating
      @website      = website
      @film_code    = film_code
      @mt_film_code = mt_film_code
      @shows        = shows
    end
  end
end
