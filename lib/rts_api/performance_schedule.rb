module RtsApi
  class PerformanceSchedule < Response

    Ticket = Struct.new(:code, :name, :price, :tax)

    Film = Struct.new(:title, :title_short, :length, :rating, :website,
                      :film_code, :mt_film_code, :shows)

    Show = Struct.new(:datetime, :auditorium, :performance_id, :sale_link,
                      :seats_remaining, :seats_sold, :sold_out, :low_seats,
                      :ticket_type_codes)

    def file_version
      get_text_node('FileVersion') 
    end

    def rts_version
      get_text_node('RtsVersion') 
    end

    def link_prefix
      get_text_node('LinkPreFix')
    end

    def tickets
      get_node_set('Tickets').map do |ticket|
        Ticket.new(
          get_text_node('Code', ticket), 
          get_text_node('Name', ticket),
          get_text_node('Price', ticket),
          get_text_node('Tax', ticket)
        )
      end
    end

    def films
      get_node_set('Films').map do |film|
        Film.new(
          get_text_node('Title', film),
          get_text_node('TitleShort', film),
          get_text_node('Length', film),
          get_text_node('Rating', film),
          get_text_node('WebSite', film),
          get_text_node('FilmCode', film),
          get_text_node('MtFilmCode', film),
          get_shows_from_film(film)
        )  
      end
    end

    private

    def get_shows_from_film(film)
      get_node_set('Shows').map do |show|
        Show.new(
          get_text_node('DT', show),
          get_text_node('Aud', show),
          get_text_node('ID', show),
          get_text_node('Link', show),
          get_text_node('RE', show),
          get_text_node('Sold', show),
          get_text_node('SO', show) == '1',
          get_text_node('LI', show) == '1',
          get_ticket_type_codes_from_show(show)
        )
      end
    end

    def get_ticket_type_codes_from_show(show)
      get_node_set('TIs').map do |ti|
        ti.at('C').text
      end
    end
  end
end
