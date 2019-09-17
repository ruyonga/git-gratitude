defmodule GitGratitude.GithubApi.HttpAdapter do

  use HTTPoison.Base

  defp access_token, do: Application.get_env(:git_gratitude, :gh_token)
  def base_url, do: Application.get_env(:git_gratitude, :base_url)

  def process_url(url) do
    base_url() <> url
  end

  def post(url, params) do
    post(url, Jason.encode!(params), headers())
  end

  def get(url) do
    get(url, headers())
  end

  defp headers do
     [
       {"Authorization", "token #{access_token()}"},
       {"Accept", " application/json"},
       {"Content-Type", "application/json"}
     ]
  end

  def process_response_body(""), do: ""
  def process_response_body(body) do
    body
    |> Jason.decode!
  end
end
