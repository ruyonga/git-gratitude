defmodule GitGratitude.GitHubApi.ApiClientBehaviour do
  @moduledoc false
  @callback find_or_create_organization(String.t(), String.t()) :: tuple()
  @callback create_org(String.t(), String.t()) :: tuple()
  @callback find_organisation(String.t()) :: tuple()
end


