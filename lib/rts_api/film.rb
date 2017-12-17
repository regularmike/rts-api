module RtsApi

  class Film

    attr_reader :title, :title_short, :length, :rating, :website, :film_code, :mt_film_code, :shows

    include XmlReader
    
    def initialize(attrs)
      @title        = attrs[:title]
      @title_short  = attrs[:title_short]
      @length       = attrs[:length]
      @rating       = attrs[:rating]
      @website      = attrs[:website]
      @film_code    = attrs[:film_code]
      @mt_film_code = attrs[:mt_film_code]
      @shows        = attrs[:shows]
    end

  end
 
end
