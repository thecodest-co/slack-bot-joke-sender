require 'interactor'

class AdjustJoke
  include Interactor

  def call
    if context.body['type'] == 'single'
      context.joke_text = context.body['joke']
    else 
      context.joke_text = context.body['setup'] + "\n" + context.body['delivery']
    end
  end
end