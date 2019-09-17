defmodule GitGratitude.GithubApi.GithubClient do

  alias GitGratitude.GithubApi.GithubApi
  alias GitGratitude.Repo

  def api_client, do: Application.get_env(:git_gratitude, :api_client)


  def create_lesson_repo(org_name, repo_name, username, team_name) do
    with {:ok, %{team: team}} <- api_client().find_or_create(org_name, username, team_name),
        {:ok, repo} <- api_client().create_repo(org_name, repo_name),
        {:ok, ""} <- api_client().add_repo_to_team(org_name, team["id"], repo_name)
      do
        #{:ok , %Repo{id:  repo["id"], url: repo["html_url"]}}

      else
        err -> err
      end
  end


end
