class IndexController < ApplicationController
  def index
    num_error = 0
    n = params[:n]
    puts "test"
    @res = []
    if is_number?(n)
      if n.to_i <= 10 ** 6
        (0..n.to_i).each do |x|
          @res << [x, x.to_s(2)] if x.to_s.reverse.to_i == x.to_i and x.to_s(2) == x.to_s(2).reverse
        end
        respond_to do |format|
          format.html
          format.json do render json: {type: @res.class.to_s, value: @res, suc: n}
          end
        end
      else
        num_error += 1
      end
    else
      num_error += 1
    end
    if num_error != 0
      @error = "Неверный формат данных"
      respond_to do |format|
        format.html
        format.json do render json: {type: @error.class.to_s, value: @error, suc: "error"}
        end
      end
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end
end
