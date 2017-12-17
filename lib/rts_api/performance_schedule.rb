module RtsApi

  class PerformanceSchedule < Response
    
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
        Ticket.new({
          code:   get_text_node('Code', ticket), 
          name:   get_text_node('Name', ticket),
          price:  get_text_node('Price', ticket),
          tax:    get_text_node('Tax', ticket)
        })
      end
    end

    def films
      get_node_set('Films').map do |film|
        Film.new({
          title:        get_text_node('Title', film),
          title_short:  get_text_node('TitleShort', film),
          length:       get_text_node('Length', film),
          rating:       get_text_node('Rating', film),
          website:      get_text_node('WebSite', film),
          film_code:    get_text_node('FilmCode', film),
          mt_film_code: get_text_node('MtFilmCode', film),
          shows:        get_shows_from_film(film)
        })  
      end
    end

    private

    def get_shows_from_film(film)
      get_node_set('Shows').map do |show|
        Show.new({
          datetime:           get_text_node('DT', show),
          auditorium:         get_text_node('Aud', show),
          performance_id:     get_text_node('ID', show),
          sale_link:          get_text_node('Link', show),
          seats_remaining:    get_text_node('RE', show),
          seats_sold:         get_text_node('Sold', show),
          sold_out?:          get_text_node('SO', show) == '1',
          low_seats?:         get_text_node('LI', show) == '1',
          ticket_type_codes:  get_ticket_type_codes_from_show(show)
        })
      end
    end

    def get_ticket_type_codes_from_show(show)
      get_node_set('TIs').map do |ti|
        ti.at('C').text
      end
    end

  end

end
