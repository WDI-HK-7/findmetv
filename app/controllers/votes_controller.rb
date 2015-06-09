class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def create
    @vote = Vote.new(vote_params)

    @vote.save
  end

  private

  def vote_params
    params.require(:vote).permit({:likes => []}, {:dislikes => []})
  end
end