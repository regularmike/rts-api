module RtsApi
  # Response subclass for working with a performance schedule response from RTS
  class PerformanceSchedule < Response
    Ticket = Struct.new(:code, :name, :price, :tax)

    Film = Struct.new(:title, :title_short, :length, :rating, :website,
                      :film_code, :mt_film_code, :shows)

    Show = Struct.new(:datetime, :auditorium, :performance_id, :sale_link,
                      :seats_remaining, :seats_sold, :sold_out, :low_seats,
                      :ticket_type_codes)

    def file_version
      text_node('FileVersion')
    end

    def rts_version
      text_node('RtsVersion')
    end

    def link_prefix
      text_node('LinkPreFix')
    end

    def tickets
      node_set('Tickets').map do |ticket|
        Ticket.new(
          text_node('Code', ticket),
          text_node('Name', ticket),
          text_node('Price', ticket),
          text_node('Tax', ticket)
        )
      end
    end

    def films
      node_set('Films').map do |film|
        Film.new(text_node('Title', film), text_node('TitleShort', film),
                 text_node('Length', film), text_node('Rating', film),
                 text_node('WebSite', film), text_node('FilmCode', film),
                 text_node('MtFilmCode', film), shows_from_film(film))
      end
    end

    private

    def shows_from_film(film)
      node_set('Shows', film).map do |show|
        Show.new(text_node('DT', show), text_node('Aud', show),
                 text_node('ID', show), text_node('Link', show),
                 text_node('RE', show), text_node('Sold', show),
                 text_node('SO', show) == '1', text_node('LI', show) == '1',
                 ticket_type_codes_from_show(show))
      end
    end

    def ticket_type_codes_from_show(show)
      node_set('TIs', show).map do |ti|
        ti.at('C').text
      end
    end
  end
end
